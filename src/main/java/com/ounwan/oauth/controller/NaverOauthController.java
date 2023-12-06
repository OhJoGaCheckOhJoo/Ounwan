package com.ounwan.oauth.controller;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.oauth.naver.NaverLoginBO;
import com.ounwan.service.ClientsService;

@RestController
@RequestMapping("/oauth")
public class NaverOauthController {

	@Autowired
	private static NaverLoginBO naverLogin;

	@Autowired
	private static ClientsService clientsService;

	private String apiResult = null;

	// callback

	// return type ModelAndView로 변경 필요
	@RequestMapping(value = "/naver", produces = "text/plain;charset=utf-8")
	public String naverLogin(@RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException {
		OAuth2AccessToken oauthToken = naverLogin.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLogin.getUserProfile(oauthToken);

		// 2. String 형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = null;
		try {
			obj = parser.parse(apiResult);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		// 3. 데이터 파싱
		JSONObject jsonObj = (JSONObject) obj;
		JSONObject response = (JSONObject) jsonObj.get("response");

		String name = (String) response.get("name");
		String email = (String) response.get("email");
		String phone = (String) response.get("mobile");
		String birthday = (String) response.get("birthyear") + "-" + (String) response.get("birthday");
		String profileURL = (String) response.get("profile_image");
		String token = (String) response.get("id");

		ClientsDTO result = clientsService.checkNaverToken(token);

		if (result == null) {
			session.setAttribute("userInfo",
					ClientsDTO.builder().name(name).email(email).phone(phone).birthday(Date.valueOf(birthday))
							.profileURL(profileURL).socialType("NAVER").socialId(token).build());
			return "signUp";
		}
		session.setAttribute("userInfo", result);
		return "login";
	}

}
