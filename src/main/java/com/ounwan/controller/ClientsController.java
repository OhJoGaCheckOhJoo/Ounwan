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

	@SuppressWarnings("static-access")
	@GetMapping(value = "/findId", consumes = "text/plain;charset=UTF-8", produces = "application/json")
	public String findId(@RequestParam("name") String name, @RequestParam("email") String email) {
		System.out.println(name + " : " + email);
		ClientsDTO clientsDTO = new ClientsDTO().builder().name(name).email(email).build();
		String id = clientService.findClientId(clientsDTO);
		return id;
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping("/findPassword")
	public String findPassword(@RequestParam("id") String id, @RequestParam("email") String email) {
		ClientsDTO clientsDTO = new ClientsDTO().builder().clientId(id).email(email).build();
		String result = clientService.findPassword(clientsDTO);
		return result;
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping("/withdrawal")
	public String withdrawal(@RequestParam("clientId") String clientId, @RequestParam("privacyTerms") int privacyTerms) {
		ClientsDTO clientsDTO = new ClientsDTO().builder().clientId(clientId).privacyTerms(privacyTerms).build();
		String result = clientService.withdrawalClient(clientsDTO);
		return result;
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

}
