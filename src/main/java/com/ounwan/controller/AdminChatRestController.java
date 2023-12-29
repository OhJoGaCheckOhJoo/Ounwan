package com.ounwan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.dto.SomsomiChatMessageDTO;
import com.ounwan.service.AdminChatService;
import com.ounwan.service.SomsomiChatService;

@RequestMapping("/admin")
@RestController
public class AdminChatRestController {	
	@Autowired
	AdminChatService adminChatService;
	
	@Autowired
	SomsomiChatService chatService;
	
	@RequestMapping("/chat/list")
	public List<SomsomiChatMessageDTO> selectDanggunChatList(@RequestParam(name = "roomId") String roomId, Model model) {
		List<SomsomiChatMessageDTO> result = adminChatService.selectSomsomiChatList(roomId);
		return result;
	}
	
	@PostMapping("/chat/insertMessage")
	public int insertMessage(SomsomiChatMessageDTO chatDTO) {
		boolean result = chatService.insertMessage(chatDTO);
		int lastMessageId = chatService.lastMessageId(chatDTO.getRoomId());
		return lastMessageId;
	}
	
	@PostMapping("/chat/delete")
	public Boolean deleteMessage(Integer messageId) {
		return chatService.deleteMessage(messageId);
	}
}
