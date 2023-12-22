package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.ChatDTO;
import com.ounwan.entity.Chat;
import com.ounwan.repository.ChatDAO;

@Service
public class ChatService {

	@Autowired
	ChatDAO chatDAO;
	
	public List<ChatDTO> selectChatList() {
		return changeDTOlist(chatDAO.selectChatList());
	}
	
	public boolean insertMessage(ChatDTO chatDTO) {
		int result = chatDAO.insertMessage(changeEntity(chatDTO));
		return (result > 0) ? true : false;
	}	
	
	public List<ChatDTO> changeDTOlist(List<Chat> chat){
		List<ChatDTO> changeList = new ArrayList<>();
		for(Chat p : chat) {
			changeList.add(changeDTO(p));
		}
		return changeList;
	}
	
	
	public ChatDTO changeDTO(Chat chat) {
		return ChatDTO.builder()
				.messageId(chat.getMessageId())
				.sender(chat.getSender())
				.message(chat.getMessage())
				.regdate(chat.getRegdate())
				.build();
	}
	
	public Chat changeEntity(ChatDTO chat) {
		return Chat.builder()
				.messageId(chat.getMessageId())
				.sender(chat.getSender())
				.message(chat.getMessage())
				.regdate(chat.getRegdate())
				.build();
	}

}
