package com.ounwan.oauth.controller;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.oauth.kakao.KakaoLoginBO;
import com.ounwan.service.ClientsService;

@Controller
@RequestMapping("/oauth")
public class KakaoOauthController {
	@Autowired
	KakaoLoginBO kakaoLogin;

	@Autowired
	ClientsService clientsService;

	@RequestMapping(value = "/kakao", produces = "text/plain;charset=utf-8")
	public String kakaoLogin(@RequestParam(required = false) String code, HttpSession session, Model model) throws IOException {
		String kakaoToken = kakaoLogin.getReturnAccessToken(code);
		session.setAttribute("accessToken", kakaoToken);
		ClientsDTO loginClient = kakaoLogin.getUserInfo(kakaoToken);
		
		if (loginClient.getClientId() == null) {
			model.addAttribute("kakaoClient", loginClient);
			return "signUp";
		}
		session.setAttribute("userInfo", loginClient);
		return "home";
	}

	@RequestMapping("/logout")
	public String kakaoLogout(HttpSession session) {
		String logout = "https://kauth.kakao.com/oauth/logout";
		String accessToken = (String)session.getAttribute("accessToken");
		String logout_redirect_uri = "http://localhost:9090/myapp/";
		StringBuilder sb = new StringBuilder();
		sb.append(logout).append("&client_id=").append(accessToken).append("&logout_redirect_uri=")
				.append(logout_redirect_uri);
		return "redirect:/" + sb.toString();
	}

	public ClientsDTO convertResult(Map<String, Object> result) {
		return ClientsDTO.builder().name((String) result.get("name")).clientId((String) result.get("clientId"))
				.profileUrl((String) result.get("profileURL")).socialId((String) result.get("token"))
				.socialType("KAKAO").build();
	}
}
