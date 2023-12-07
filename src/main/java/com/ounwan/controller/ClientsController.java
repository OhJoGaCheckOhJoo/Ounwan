package com.ounwan.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
		int result = clientsService.createAccount(client);
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
		boolean result = clientsService.checkId(clientId);
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
		boolean result = clientsService.checkEmail(email);
		if(result) {
			System.out.println("YESSSSSS");
		} else {
			System.out.println("NOOOOOOOOO");
		}
		return "success";
	} 

}
