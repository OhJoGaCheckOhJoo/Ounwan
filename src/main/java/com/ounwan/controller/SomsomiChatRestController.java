package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.SomsomiChatMessageDTO;
import com.ounwan.service.SomsomiChatService;

@RequestMapping("/somsomi")
@RestController
public class SomsomiChatRestController {
	
	@Autowired
	SomsomiChatService chatService;
	
	@RequestMapping("/chat/list")
	public List<SomsomiChatMessageDTO> selectSomsomiChatList(HttpSession session){
		ClientsDTO clients = (ClientsDTO) session.getAttribute("userInfo");
		List<SomsomiChatMessageDTO> result = chatService.selectSomsomiChatList(clients.getClientId());
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
