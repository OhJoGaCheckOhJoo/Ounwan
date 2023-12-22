package com.ounwan.oauth.controller;

import java.io.IOException;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.oauth.google.GoogleLoginBO;
import com.ounwan.service.ClientsService;

@Controller
@RequestMapping("/oauth")
public class GoogleOauthController {
	
	@Autowired
	ClientsService clientsService;
	
	@Autowired
	GoogleLoginBO googleLoginBO;
	
	@GetMapping("/google")
	public String googleLogin(@RequestParam String code, HttpSession session, Model model) throws IOException {
		ClientsDTO loginClient = googleLoginBO.getUserInfo(googleLoginBO.getRequest(code));
		System.out.println(loginClient);
		
		if(loginClient.getClientId() == null) {
			model.addAttribute("googleClient", loginClient);
			return "signUp";
		}
		session.setAttribute("userInfo", loginClient);
		return "home";
	}
}
// 116284180177924084473