package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.SomsomiChatMessageDTO;
import com.ounwan.dto.SomsomiChatRoomDTO;
import com.ounwan.entity.Clients;
import com.ounwan.entity.SomsomiChatMessage;
import com.ounwan.entity.SomsomiChatRoom;
import com.ounwan.repository.AdminChatDAO;
import com.ounwan.repository.MyPageChatDAO;
import com.ounwan.repository.SomsomiChatDAO;

@Service
public class AdminChatService {

	@Autowired
	AdminChatDAO adminChatDAO;
	
	@Autowired
	MyPageChatDAO myPageChatDAO;
	
	@Autowired
	SomsomiChatDAO chatDAO;
	
	public List<Map<String, Object>> getSomsomiRoomList() {
		List<SomsomiChatRoomDTO> roomList = changeRoomDTOlist(adminChatDAO.getSomsomiRoomList());
		
		List<Map<String, Object>> clientInfo = new ArrayList<>();
		
		for(SomsomiChatRoomDTO chatRoom : roomList) {
			Map<String, Object> chatInfo = new HashMap<>(); 
			
			String clientId = chatRoom.getClientId();
			
			chatInfo.put("chatRoom", chatRoom);
			Clients client = myPageChatDAO.getPartnerInfo(clientId);
			chatInfo.put("client", client);
			clientInfo.add(chatInfo);
		}
		
		return clientInfo;
	}
	
	public List<SomsomiChatMessageDTO> selectSomsomiChatList(String roomId) {
		List<SomsomiChatMessageDTO> result = changeDTOlist(chatDAO.selectSomsomiChatList(roomId));
		return result;
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
	
	public List<SomsomiChatRoomDTO> changeRoomDTOlist(List<SomsomiChatRoom> chat){
		List<SomsomiChatRoomDTO> changeList = new ArrayList<>();
		for(SomsomiChatRoom p : chat) {
			changeList.add(changeRoomDTO(p));
		}
		return changeList;
	}
	
	public SomsomiChatRoomDTO changeRoomDTO(SomsomiChatRoom chat) {
		return SomsomiChatRoomDTO.builder()
				.roomId(chat.getRoomId())
				.adminId(chat.getAdminId())
				.clientId(chat.getClientId())
				.resolvedStatus(chat.getResolvedStatus())
				.build();
	}
	
	public SomsomiChatRoom changeRoomEntity(SomsomiChatRoomDTO chat) {
		return SomsomiChatRoom.builder()
				.roomId(chat.getRoomId())
				.adminId(chat.getAdminId())
				.clientId(chat.getClientId())
				.resolvedStatus(chat.getResolvedStatus())
				.build();
	}

}
