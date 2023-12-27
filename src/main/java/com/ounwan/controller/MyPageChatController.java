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
	
	@GetMapping(value = "/chatList")
	public String chatList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();	
		model.addAttribute("chatList", myPageChatService.getchatList(clientId));
		return "/myPage/chatList";
	}
	
	@GetMapping(value = "/getChatRoom")
	public String getChatRoom(Model model,@RequestParam("roomId") String roomId) {
		model.addAttribute("roomId", roomId);
		return "/myPage/chatRoom";
	}
	

}
