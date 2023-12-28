package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.SomsomiChatRoomDTO;
import com.ounwan.entity.Clients;
import com.ounwan.entity.SomsomiChatRoom;
import com.ounwan.repository.AdminChatDAO;
import com.ounwan.repository.MyPageChatDAO;

@Service
public class AdminChatService {

	@Autowired
	AdminChatDAO adminChatDAO;
	
	@Autowired
	MyPageChatDAO myPageChatDAO;
	
	public List<Map<String, Object>> getSomsomiRoomList() {
		List<SomsomiChatRoomDTO> roomList = changeDTOlist(adminChatDAO.getSomsomiRoomList());
		
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
	
	public List<SomsomiChatRoomDTO> changeDTOlist(List<SomsomiChatRoom> chat){
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
