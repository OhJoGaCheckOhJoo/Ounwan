package com.ounwan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.dto.SomsomiChatDTO;
import com.ounwan.service.SomsomiChatService;

@RequestMapping("/bixSiri")
@RestController
public class SomsomiChatRestController {
	
	@Autowired
	SomsomiChatService chatService;
	
	@RequestMapping("/chat/list")
	public List<SomsomiChatDTO> selectChatList(){
		List<SomsomiChatDTO> result = chatService.selectChatList();
		return result;
	}
	
	@PostMapping("/chat/insertMessage")
	public Boolean insertMessage(SomsomiChatDTO chatDTO) {
		return chatService.insertMessage(chatDTO);
	}
	
}
