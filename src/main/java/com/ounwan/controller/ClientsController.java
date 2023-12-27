package com.ounwan.controller;
	
import java.io.IOException;
import java.util.List;

import javax.mail.MessagingException;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.CartsDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.oauth.google.GoogleLoginBO;
import com.ounwan.oauth.kakao.KakaoLoginBO;
import com.ounwan.oauth.naver.NaverLoginBO;
import com.ounwan.service.CartService;
import com.ounwan.service.ClientsService;

@RequestMapping("/clients")
@Controller
public class ClientsController {

	@Autowired
	ClientsService clientService;
	
	@Autowired
	CartService cartService;

	@Autowired
	KakaoLoginBO kakaoLogin;

	@Autowired
	NaverLoginBO naverLogin;
	
	@Autowired
	GoogleLoginBO googleLogin;

	@GetMapping("/login")
	public String loginGet(HttpSession session) {
		return "login";
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public @ResponseBody String loginPost(@RequestBody ClientsDTO client, HttpSession session) {
        ClientsDTO loginUser = clientService.checkLogin(client.getClientId(), client.getPassword());
        List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");
        
        if (loginUser != null) {
        	if (!loginUser.getEmailCheck())
        		return "unAuthorized";
        	if (!loginUser.getActivationCheck())
        		return "withdraw";
            session.setAttribute("userInfo", loginUser);
            if(cartList != null) {
            	for (CartsDTO cart : cartList) {
            		cart.setClientId(loginUser.getClientId());
            		cartService.addToCart(cart);
            		session.removeAttribute("cartList");
            	}
            }
            return "success";
        }
        return "fail";
    }

	@SuppressWarnings("static-access")
	@GetMapping(value = "/findId", consumes = "text/plain;charset=UTF-8", produces = "application/json")
	public String findId(@RequestParam("name") String name, @RequestParam("email") String email) {
		return clientService.findClientId(new ClientsDTO().builder().name(name).email(email).build());
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping("/findPassword")
	public String findPassword(@RequestParam("id") String id, @RequestParam("email") String email) throws MessagingException {
		return clientService.findPassword(id, email);
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping("/withdrawal")
	public String withdrawal(@RequestParam("clientId") String clientId, @RequestParam("privacyTerms") int privacyTerms) {
		return clientService.withdrawalClient(new ClientsDTO().builder().clientId(clientId).privacyTerms(privacyTerms).build());
	}
	// Rest Api 처리 필
	@RequestMapping("/logout")
	public @ResponseBody String logoutGet(HttpSession session) {
		String accessToken = (String) session.getAttribute("accessToken");
		if (accessToken != null) {
			kakaoLogin.logout(session);
			session.invalidate();
			return "success";
		}
		session.invalidate();
		return "success";
	}

	@RequestMapping("/login/kakao")
	public String kakaoLogin() {
		return "redirect:" + kakaoLogin.getURL();
	}
	
	@RequestMapping("/login/naver")
	public String naverLogin(HttpSession session) {
		return "redirect:" + naverLogin.getAuthorizationUrl(session);
	}
	
	@RequestMapping("/login/google")
	public String googleLogin() {
		return "redirect:" + googleLogin.getURL();
	}
	
	@GetMapping("/signUp")
	public String createAccount () {  
		return "signUp";
	}

	@PostMapping(value = "/signUp", consumes= "application/json", produces="text/plain;charset=utf-8")
	public @ResponseBody String createAccount(@RequestBody ClientsDTO client) throws MessagingException {
		boolean result = clientService.createAccount(client);
		return (result) ? "success" : "fail";
	} 
	
	@GetMapping("/checkId")
	public @ResponseBody String checkId(String clientId) {
		System.out.println(clientId);
		// true = id 존재, false = id 없음
		boolean result = clientService.checkId(clientId);
		return (result) ? "exist" : "available";
	} 
	
	@GetMapping("/checkEmail")
	public @ResponseBody String checkEmail(String email) {
		// true = id 존재, false = id 없음
		boolean result = clientService.checkEmail(email);
		return (result) ? "exist" : "available";
	} 
	
	@GetMapping("/emailAuth")
	public String getAuthPage() {
		return "emailCheck";
	}
	
	@PostMapping(value = "/emailAuth", consumes = "application/json")
	public @ResponseBody String checkEmailAuthString (@RequestBody ClientsDTO client) {
		boolean result = clientService.checkEmailAuth(client);
		return (result) ? "success" : "fail";
	}
	
	@PostMapping(value="/setImage")
	public @ResponseBody String setImage(@RequestParam("image") MultipartFile image) throws IllegalStateException, IOException {
		String imgString = clientService.setImage(image);
		System.out.println("이미지다아아!!!!! : " + imgString);
		return imgString;
	}
}
