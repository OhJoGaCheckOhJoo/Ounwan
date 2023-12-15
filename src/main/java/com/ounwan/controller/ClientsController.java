package com.ounwan.controller;
	
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
import org.springframework.web.servlet.ModelAndView;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.oauth.kakao.KakaoLoginBO;
import com.ounwan.oauth.naver.NaverLoginBO;
import com.ounwan.service.ClientsService;

@RequestMapping("/clients")
@Controller
public class ClientsController {

	@Autowired
	ClientsService clientService;

	@Autowired
	KakaoLoginBO kakaoLogin;

	@Autowired
	NaverLoginBO naverLogin;


	@GetMapping("/login")
	public String loginGet(HttpSession session) {
		return "login";
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String loginPost(@RequestBody ClientsDTO client, HttpSession session) {
		System.out.println("내가 입력 비번 : " + client.getPassword());
		ClientsDTO loginUser = clientService.checkLogin(client.getClientId(), client.getPassword());
		System.out.println(loginUser);
		if (loginUser != null) {
			session.setAttribute("userInfo", loginUser);
			System.out.println("clients : " + client);
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
	public String findPassword(@RequestParam("id") String id, @RequestParam("email") String email) {
		return clientService.findPassword(new ClientsDTO().builder().clientId(id).email(email).build());
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping("/withdrawal")
	public String withdrawal(@RequestParam("clientId") String clientId, @RequestParam("privacyTerms") int privacyTerms) {
		return clientService.withdrawalClient(new ClientsDTO().builder().clientId(clientId).privacyTerms(privacyTerms).build());
	}

	@RequestMapping("/logout")
	public ModelAndView logoutGet(HttpSession session) {
		ModelAndView v = new ModelAndView("home");
		String accessToken = (String) session.getAttribute("accessToken");
		System.out.println("KAKAO L:OGOUTTTTTTTTTTTTTT");
		System.out.println("AccessToken : " + accessToken);
		if (accessToken != null) {
			kakaoLogin.logout(session);
			session.invalidate();
			return v;
		}
		session.invalidate();
		return v;
	}

	@RequestMapping("/login/kakao")
	public String kakaoLogin() {
		return "redirect:" + kakaoLogin.getURL();
	}
	
	@RequestMapping("/login/naver")
	public String naverLogin(HttpSession session) {
		return "redirect:" + naverLogin.getAuthorizationUrl(session);
	}

	@PostMapping(value = "/signUp", consumes= "application/json", produces="text/plain;charset=utf-8")
	public String createAccount(@RequestBody ClientsDTO client) {
		System.out.println(client);
		int result = clientService.createAccount(client);
		if(result > 0) {
			System.out.println("YESSSSSS");
		} else {
			System.out.println("NOOOOOOOOO");
		}
		return "success";
	} 
	
	@GetMapping(value = "/checkId", produces="text/plain;charset=utf-8")
	public String checkId(String clientId) {
		System.out.println(clientId);
		// true = id 존재, false = id 없음
		boolean result = clientService.checkId(clientId);
		if(result) {
			System.out.println("YESSSSSS");
		} else {
			System.out.println("NOOOOOOOOO");
		}
		return "success";
	} 
	
	@GetMapping(value = "/checkEmail", produces="text/plain;charset=utf-8")
	public String checkEmail(String email) {
		System.out.println(email);
		// true = id 존재, false = id 없음
		boolean result = clientService.checkEmail(email);
		if(result) {
			System.out.println("YESSSSSS");
		} else {
			System.out.println("NOOOOOOOOO");
		}
		return "success";
	} 

}
