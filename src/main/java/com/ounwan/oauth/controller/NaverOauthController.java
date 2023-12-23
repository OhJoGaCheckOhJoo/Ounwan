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
import org.springframework.web.servlet.ModelAndView;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.oauth.naver.NaverLoginBO;
import com.ounwan.service.ClientsService;

@RestController
@RequestMapping("/oauth")
public class NaverOauthController {

	@Autowired
	NaverLoginBO naverLogin;

	@Autowired
	ClientsService clientsService;

	private String apiResult = null;

	// return type modelandview로 변경 필요
	@RequestMapping(value = "/naver", produces = "text/plain;charset=utf-8")
	public ModelAndView naverLogin(@RequestParam String code, @RequestParam String state, HttpSession session)
			throws IOException, ParseException {
		ModelAndView mv = new ModelAndView("home");
		
		OAuth2AccessToken oauthToken = naverLogin.getAccessToken(session, code, state);

		apiResult = naverLogin.getUserProfile(oauthToken);

		ClientsDTO naverClient = convertResult(apiResult);
		ClientsDTO result = clientsService.checkNaverToken(naverClient.getSocialId());

		if (result == null) {
			session.setAttribute("userInfo", naverClient);
			System.out.println(naverClient);
			return mv;
		}
		session.setAttribute("userInfo", result);
		System.out.println(result);
		return mv;
	}

	public ClientsDTO convertResult(String apiResult) throws ParseException {
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);

		JSONObject jsonObj = (JSONObject) obj;
		JSONObject response = (JSONObject) jsonObj.get("response");

		String birthday = (String) response.get("birthyear") + "-" + (String) response.get("birthday");

		return ClientsDTO.builder().name((String) response.get("name")).email((String) response.get("email"))
				.phone((String) response.get("phone")).birthday(Date.valueOf(birthday))
				.profileUrl((String) response.get("profile_image")).socialId((String) response.get("id"))
				.socialType("NAVER").build();
	}
}
