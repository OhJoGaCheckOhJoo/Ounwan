package com.ounwan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ounwan.service.CommunityService;

@Controller
public class CommunityController {
	
	@Autowired
	CommunityService communityService;
	
	@RequestMapping("/ounwangram")
	public String ounwangram() {
		return "community/ounwangram";
	}
	
	@RequestMapping("/aeta")
	public String aeta() {
		return "login";
	}
	
}
