package com.ounwan.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ounwan.service.ClientsService;
import com.ounwan.service.CommunityService;

@Controller
public class CommunityController {
	
	@Autowired
	CommunityService communityService;
	
	@Autowired
	ClientsService clientsService;
	
	@RequestMapping("/ounwangram")
	public String ounwangram(HttpSession session) {
		
		if(session.getAttribute("clientInfo") == null) { // 비로그인 > 로그인창
			return "login";
		} else {
			return "community/ounwangram"; // 로그인 > 오늘운동했다그램
		}
	}

}
