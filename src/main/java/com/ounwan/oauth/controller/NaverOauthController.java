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

	// return type modelandview로 변경 필요
	@RequestMapping(value = "/naver", produces = "text/plain;charset=utf-8")
	public String NaverLogin(@RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException {
		OAuth2AccessToken oauthToken = naverLogin.getAccessToken(session, code, state);

		apiResult = naverLogin.getUserProfile(oauthToken);

		JSONParser parser = new JSONParser();
		Object obj = null;
		try {
			obj = parser.parse(apiResult);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

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
			session.setAttribute("userInfo", ClientsDTO.builder()
														.name(name)
														.email(email)
														.phone(phone)
														.birthday(Date.valueOf(birthday))
														.profileURL(profileURL)
														.socialType("NAVER")
														.socialId(token)
														.build());
			return null;
		}
		session.setAttribute("userInfo", result);

		return null;
	}

}
