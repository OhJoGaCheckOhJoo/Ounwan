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
			throws IOException, ParseException {
		OAuth2AccessToken oauthToken = naverLogin.getAccessToken(session, code, state);
		// 1. 로그인 사용자 정보를 읽어온다.
		apiResult = naverLogin.getUserProfile(oauthToken);
		
		ClientsDTO naverClient = convertResult(apiResult);
		ClientsDTO client = clientsService.checkNaverToken(naverClient.getSocialId());

		if (client == null) {
			session.setAttribute("userInfo", naverClient);
			return "signUp";
		}
		session.setAttribute("userInfo", client);
		return "login";
	}
	
	public ClientsDTO convertResult(String apiResult) throws ParseException {
		// 2. String 형식인 apiResult를 json형태로 바꿈
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);

		// 3. 데이터 파싱
		JSONObject jsonObj = (JSONObject) obj;
		JSONObject response = (JSONObject) jsonObj.get("response");
		String birthday = (String) response.get("birthyear") + "-" + (String) response.get("birthday");
		
		return ClientsDTO.builder()
				.name((String)response.get("name"))
				.email((String)response.get("email"))
				.phone((String)response.get("mobile"))
				.birthday(Date.valueOf(birthday))
				.profileURL((String)response.get("profile_image"))
				.socialId((String)response.get("id"))
				.socialType("KAKAO")
				.build();
	}

}
