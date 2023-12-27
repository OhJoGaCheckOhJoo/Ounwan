package com.ounwan.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.MyPageChatService;

@RequestMapping("/myPage")
@Controller
public class MyPageChatController {
	
	@Autowired
	MyPageChatService myPageChatService;
	
	String clientId="jj1234";
	
	@GetMapping(value = "/chatList")
	public String chatList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();	
		model.addAttribute("chatList", myPageChatService.getchatList(clientId));
		return "/myPage/chatList";
	}
	
	@GetMapping(value = "/getChatRoom")
	public String getChatRoom(HttpSession session, Model model,@RequestParam("roomId") String roomId) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();	
		System.out.println(roomId);
		
		model.addAttribute("roomId", roomId);
//		model.addAttribute("chatInfo", myPageService.getchatList(clientId));
		return "/myPage/chatRoom";
	}
	

}
