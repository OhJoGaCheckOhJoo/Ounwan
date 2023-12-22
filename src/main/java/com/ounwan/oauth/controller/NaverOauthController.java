package com.ounwan.oauth.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.github.scribejava.core.model.OAuth2AccessToken;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.oauth.naver.NaverLoginBO;
import com.ounwan.service.ClientsService;

@Controller
@RequestMapping("/oauth")
public class NaverOauthController {

	@Autowired
	NaverLoginBO naverLogin;

	@Autowired
	ClientsService clientsService;

	@RequestMapping(value = "/naver", produces = "text/plain;charset=utf-8")
	public String naverLogin(@RequestParam String code, @RequestParam String state, HttpSession session, Model model)
			throws IOException, ParseException {
	
		OAuth2AccessToken oauthToken = naverLogin.getAccessToken(session, code, state);

		ClientsDTO naverClient = naverLogin.getUserProfile(oauthToken);
		
		if (naverClient.getClientId() == null) {
			model.addAttribute("naverClient", naverClient);
			return "signUp";
		}	
		
		session.setAttribute("userInfo", naverClient);
		return "home";
	}
}
