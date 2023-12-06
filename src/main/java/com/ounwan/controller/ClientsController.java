package com.ounwan.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ounwan.oauth.kakao.KakaoLoginBO;
import com.ounwan.oauth.naver.NaverLoginBO;
import com.ounwan.service.ClientsService;

//@RequestMapping("/clients")
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
	
	@RequestMapping("/login/kakao")
	public String kakaoLogin() {		
		return "redirect:" + kakaoLogin.getURL();
		
	}
	

}
