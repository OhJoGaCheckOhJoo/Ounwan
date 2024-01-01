package com.ounwan.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.service.AdminChatService;

@RequestMapping("/admin")
@Controller
public class AdminChatController {
	
	@Autowired
	AdminChatService adminChatService;
	
	@GetMapping("/clients/chat.do")
	public String getClientChat(Model model) {
		List<Map<String, Object>> result = adminChatService.getSomsomiRoomList();
		model.addAttribute("chatRoom", result);
		return "admin/adminChatList";
	}
	
	@GetMapping(value = "/getChatRoom")
	public String getChatRoom(Model model,@RequestParam("roomId") String roomId) {
		model.addAttribute("roomId", roomId);
		return "/admin/adminChatRoom";
	}
	
}
