package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.SomsomiChatMessageDTO;
import com.ounwan.entity.SomsomiChatMessage;
import com.ounwan.entity.SomsomiChatRoom;
import com.ounwan.repository.SomsomiChatDAO;

@Service
public class SomsomiChatService {

	@Autowired
	SomsomiChatDAO chatDAO;
	
	public List<SomsomiChatMessageDTO> selectSomsomiChatList(String clientId) {
		List<String> somsomiChatRoom = chatDAO.selectRoomList();
		SomsomiChatRoom makeChatRoom = new SomsomiChatRoom();
//		일단 방이 존재하는지 체크
		String roomId = clientId + clientId;
		makeChatRoom.setRoomId(roomId);
		makeChatRoom.setClientId(clientId);
		makeChatRoom.setAdminId("admin");
		
		if(somsomiChatRoom.contains(makeChatRoom)) {
			chatDAO.makeRoom(makeChatRoom);
		}
		
		List<SomsomiChatMessageDTO> result = changeDTOlist(chatDAO.selectSomsomiChatList(roomId));
		System.out.println(result);
		return result;
	}
	
	public boolean insertMessage(SomsomiChatMessageDTO chatDTO) {
		int result = chatDAO.insertMessage(changeEntity(chatDTO));
		return (result > 0) ? true : false;
	}	
	
	public int lastMessageId(String roomId) {
		return chatDAO.lastMessageId(roomId);
	}
	
	public Boolean deleteMessage(Integer messageId) {
		int result = chatDAO.deleteMessage(messageId);
		return (result > 0) ? true : false;
	}

	public List<SomsomiChatMessageDTO> changeDTOlist(List<SomsomiChatMessage> chat){
		List<SomsomiChatMessageDTO> changeList = new ArrayList<>();
		for(SomsomiChatMessage p : chat) {
			changeList.add(changeDTO(p));
		}
		return changeList;
	}
	
	
	public SomsomiChatMessageDTO changeDTO(SomsomiChatMessage chat) {
		return SomsomiChatMessageDTO.builder()
				.roomId(chat.getRoomId())
				.messageId(chat.getMessageId())
				.sender(chat.getSender())
				.message(chat.getMessage())
				.regdate(chat.getRegdate())
				.build();
	}
	
	public SomsomiChatMessage changeEntity(SomsomiChatMessageDTO chat) {
		return SomsomiChatMessage.builder()
				.roomId(chat.getRoomId())
				.messageId(chat.getMessageId())
				.sender(chat.getSender())
				.message(chat.getMessage())
				.regdate(chat.getRegdate())
				.build();
	}

}
