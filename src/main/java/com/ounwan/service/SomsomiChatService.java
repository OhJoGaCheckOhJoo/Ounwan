package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.SomsomiChatDTO;
import com.ounwan.entity.SomsomiChat;
import com.ounwan.repository.SomsomiChatDAO;

@Service
public class SomsomiChatService {

	@Autowired
	SomsomiChatDAO chatDAO;
	
	public List<SomsomiChatDTO> selectChatList() {
		return changeDTOlist(chatDAO.selectChatList());
	}
	
	public boolean insertMessage(SomsomiChatDTO chatDTO) {
		int result = chatDAO.insertMessage(changeEntity(chatDTO));
		return (result > 0) ? true : false;
	}	
	
	public List<SomsomiChatDTO> changeDTOlist(List<SomsomiChat> chat){
		List<SomsomiChatDTO> changeList = new ArrayList<>();
		for(SomsomiChat p : chat) {
			changeList.add(changeDTO(p));
		}
		return changeList;
	}
	
	
	public SomsomiChatDTO changeDTO(SomsomiChat chat) {
		return SomsomiChatDTO.builder()
				.messageId(chat.getMessageId())
				.sender(chat.getSender())
				.message(chat.getMessage())
				.regdate(chat.getRegdate())
				.build();
	}
	
	public SomsomiChat changeEntity(SomsomiChatDTO chat) {
		return SomsomiChat.builder()
				.messageId(chat.getMessageId())
				.sender(chat.getSender())
				.message(chat.getMessage())
				.regdate(chat.getRegdate())
				.build();
	}

}
