package com.ounwan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.dto.ChatDTO;
import com.ounwan.service.ChatService;

@RequestMapping("/bixSiri")
@RestController
public class ChatRestController {
	
	@Autowired
	ChatService chatService;
	
	@RequestMapping("/chat/list")
	public List<ChatDTO> selectChatList(){
		List<ChatDTO> result = chatService.selectChatList();
		return result;
	}
	
	@PostMapping("/chat/insertMessage")
	public Boolean insertMessage(ChatDTO chatDTO) {
		return chatService.insertMessage(chatDTO);
	}
	
}
