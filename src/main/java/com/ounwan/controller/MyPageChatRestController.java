package com.ounwan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.dto.DanggunChatMessageDTO;
import com.ounwan.service.MyPageChatService;

@RequestMapping("/myPage")
@RestController
public class MyPageChatRestController {
	
	@Autowired
	MyPageChatService myPageChatService;
	
	String id="jj1234";
	
	@RequestMapping("/danggun/chat/list")
	public List<DanggunChatMessageDTO> selectDanggunChatList(@RequestParam(name = "roomId") String roomId) {
		List<DanggunChatMessageDTO> result = myPageChatService.selectDanggunChatList(roomId);
		return result;
	}

	@PostMapping("/danggun/chat/insertMessage")
	public int insertMessage(DanggunChatMessageDTO danggunChatMessageDTO) {
		boolean result = myPageChatService.insertMessage(danggunChatMessageDTO);
		int lastMessageId = myPageChatService.lastMessageId(danggunChatMessageDTO.getRoomId());
		return lastMessageId;
	}
	
	@PostMapping("/danggun/chat/delete")
	public Boolean deleteMessage(Integer messageId) {
		return myPageChatService.deleteMessage(messageId);
	}
	
}
