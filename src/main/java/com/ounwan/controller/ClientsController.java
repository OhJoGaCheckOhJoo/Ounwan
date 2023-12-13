package com.ounwan.controller;
	
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	private static String ounwanAPIURL = null;

	@GetMapping("/login")
	public ModelAndView loginGet(HttpSession session) {
		ModelAndView v = new ModelAndView("login");
		ounwanAPIURL = naverLogin.getAuthorizationUrl(session);
		System.out.println(ounwanAPIURL);
		return v;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String loginPost(String clientId, String password, HttpServletRequest request, RedirectAttributes attr,
			HttpSession session) {
		boolean result = clientService.checkLogin(clientId, password);
		if (result) {
			session.setAttribute("clientId", clientId);
		}
		return (result) ? "로그인 성공" : "로그인 실패";
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
	
	@GetMapping("/signUp")
	public String createAccount () {
		return "signUp";
	}

	@PostMapping(value = "/signUp", consumes= "application/json", produces="text/plain;charset=utf-8")
	public @ResponseBody String createAccount(@RequestBody ClientsDTO client) {
		System.out.println(client);
		int result = clientService.createAccount(client);
		return (result > 0) ? "success" : "fail";
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
		System.out.println(email);
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
}
