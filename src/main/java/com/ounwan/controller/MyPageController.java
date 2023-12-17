package com.ounwan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.MyPageService;

@RequestMapping("/myPage")
@Controller
public class MyPageController {
	
	@Autowired
	MyPageService myPageService;
	
	
	@GetMapping(value = "/modifyUserInfo", consumes= "application/json", produces="text/plain;charset=utf-8")
	public String showUserInfo(@RequestParam String clientId , Model model) {
		ClientsDTO userInfo = MyPageService.getUserInfo(clientId);
		model.addAttribute(userInfo);
		return "success";
		
	}
	
	@PostMapping(value = "/modifyUserInfo", consumes= "application/json", produces="text/plain;charset=utf-8")
	public String modifyUserInfo(@RequestBody ClientsDTO clientsDTO){
		MyPageService.modifyUserInfo(clientsDTO);
		return "";
		
	}
	
}
