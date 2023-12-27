package com.ounwan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.dto.DanggunChatMessageDTO;
import com.ounwan.service.DanggunChatService;

@RequestMapping("/danggun")
@RestController
public class DanggunChatRestController {
	@Autowired
	DanggunChatService danggunChatService;

	@RequestMapping("/bixSiri/chat/list")
	public List<DanggunChatMessageDTO> selectDanggunChatList(@RequestParam(name = "seller") String seller,
			@RequestParam(name = "buyer") String buyer, @RequestParam(name = "danggunNumber") Integer danggunNumber) {
		List<DanggunChatMessageDTO> result = danggunChatService.selectDanggunChatList(danggunNumber, seller, buyer);
		return result;
	}

	@PostMapping("/bixSiri/chat/insertMessage")
	public int insertMessage(DanggunChatMessageDTO danggunChatMessageDTO) {
		boolean result = danggunChatService.insertMessage(danggunChatMessageDTO);
		int lastMessageId = danggunChatService.lastMessageId(danggunChatMessageDTO.getRoomId());
		return lastMessageId;
	}
	
	@PostMapping("/bixSiri/chat/delete")
	public Boolean deleteMessage(Integer messageId) {
		return danggunChatService.deleteMessage(messageId);
	}

}
