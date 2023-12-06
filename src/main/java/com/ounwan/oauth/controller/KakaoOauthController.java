package com.ounwan.oauth.controller;

import java.io.IOException;
import java.sql.Date;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.oauth.kakao.KakaoLoginBO;
import com.ounwan.service.ClientsService;

@Controller
@RequestMapping("/oauth")
public class KakaoOauthController {
	@Autowired
	private static KakaoLoginBO kakaoLogin;
	
	@Autowired
	private static ClientsService clientsService;
	
	//callback
	@GetMapping("/kakao")
	public String kakaoLogin(@RequestParam String code, HttpSession session) throws IOException {
		String kakaoToken = kakaoLogin.getReturnAccessToken(code);
		Map<String,Object> result = kakaoLogin.getUserInfo(kakaoToken);
		
		ClientsDTO kakaoClient = convertResult(result);
		ClientsDTO client = clientsService.checkKakaoToken(kakaoClient.getSocialId());
		
		if(client == null) {
			session.setAttribute("userInfo", client);
			return "signUp";
		}
		session.setAttribute("userInfo", client);
		return "login";
	}
	
	public ClientsDTO convertResult(Map<String, Object> result) {
		return ClientsDTO.builder()
				.name((String)result.get("name"))
				.email((String)result.get("email"))
				.birthday((Date)result.get("birthday"))
				.phone((String)result.get("phone"))
				.profileURL((String)result.get("profileURL"))
				.socialId((String)result.get("token"))
				.socialType("KAKAO")
				.build();
	}
	
}
