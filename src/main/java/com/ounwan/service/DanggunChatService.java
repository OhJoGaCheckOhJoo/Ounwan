package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.DanggunChatMessageDTO;
import com.ounwan.entity.DanggunChatMessage;
import com.ounwan.entity.DanggunChatRoom;
import com.ounwan.repository.DanggunChatDAO;

@Service
public class DanggunChatService {
	
	@Autowired
	DanggunChatDAO danggunChatDAO;
	
	public List<DanggunChatMessageDTO> selectDanggunChatList(Integer danggunNumber ,String seller, String buyer){
//		일단 채팅방이 있는지 확인하자
		List<String> danggunChatRoom = danggunChatDAO.selectRoomList();
		DanggunChatRoom makeChatRoom = new DanggunChatRoom();
		String roomId = seller + buyer + danggunNumber;
		makeChatRoom.setRoomId(roomId);
		makeChatRoom.setDanggunNumber(danggunNumber);
		makeChatRoom.setSeller(seller);
		makeChatRoom.setBuyer(buyer);
		if(!danggunChatRoom.contains(roomId)) {
			int makeRoom = danggunChatDAO.makeRoom(makeChatRoom);
		}
		return changeDTOlist(danggunChatDAO.selectDanggunChatList(roomId));
	}
	
	public boolean insertMessage(DanggunChatMessageDTO danggunChatMessageDTO) {
		int result = danggunChatDAO.insertMessage(changeEntity(danggunChatMessageDTO));
		return (result > 0) ? true : false;
	}
	
	public boolean deleteMessage(Integer messageId) {
		int result = danggunChatDAO.deleteMessage(messageId);
		return (result > 0) ? true : false;
	}
	
	public int lastMessageId(String roomId) {
		return danggunChatDAO.lastMessageId(roomId);
	}
	
	public List<DanggunChatMessageDTO> changeDTOlist(List<DanggunChatMessage> danggunChat){
		List<DanggunChatMessageDTO> changeList = new ArrayList<>();
		for(DanggunChatMessage p : danggunChat) {
			changeList.add(changeDTO(p));
		}
		return changeList;
	}
	
	
	public DanggunChatMessageDTO changeDTO(DanggunChatMessage danggunChat) {
		return DanggunChatMessageDTO.builder()
				.messageId(danggunChat.getMessageId())
				.roomId(danggunChat.getRoomId())
				.sender(danggunChat.getSender())
				.message(danggunChat.getMessage())
				.regdate(danggunChat.getRegdate())
				.build();
	}
	
	public DanggunChatMessage changeEntity(DanggunChatMessageDTO danggunChat) {
		return DanggunChatMessage.builder()
				.messageId(danggunChat.getMessageId())
				.roomId(danggunChat.getRoomId())
				.sender(danggunChat.getSender())
				.message(danggunChat.getMessage())
				.regdate(danggunChat.getRegdate())
				.build();
	}

}
