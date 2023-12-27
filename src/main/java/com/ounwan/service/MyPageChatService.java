package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.DanggunChatMessageDTO;
import com.ounwan.dto.DanggunChatRoomDTO;
import com.ounwan.entity.Clients;
import com.ounwan.entity.DanggunChatMessage;
import com.ounwan.entity.DanggunChatRoom;
import com.ounwan.repository.ClientsDAO;
import com.ounwan.repository.MyPageChatDAO;

@Service
public class MyPageChatService {

	@Autowired
	MyPageChatDAO myPageChatDAO;

	@Autowired
	ClientsDAO clientsDAO;

	public List<Map<String, Object>> getchatList(String userId) {
		List<DanggunChatRoomDTO> chatList = changeDTORoomList(myPageChatDAO.getchatList(userId));

		List<Map<String, Object>> partners = new ArrayList<>();

		for (DanggunChatRoomDTO chatRoom : chatList) {
			Map<String, Object> chatInfo = new HashMap<>();

			String seller = chatRoom.getSeller();
			String buyer = chatRoom.getBuyer();

			chatInfo.put("chatRoom", chatRoom);

			if (seller.equals(userId)) {
				// 판매자일 경우
				Clients partnerInfo = myPageChatDAO.getPartnerInfo(buyer);
				chatInfo.put("partnerInfo", partnerInfo);
			} else if (buyer.equals(userId)) {
				// 구매자일 경우
				Clients partnerInfo = myPageChatDAO.getPartnerInfo(seller);
				chatInfo.put("partnerInfo", partnerInfo);
			}
			// partners 리스트에 해당 Map 추가
			partners.add(chatInfo);
		}

		return partners;
	}
	
	public List<DanggunChatMessageDTO> selectDanggunChatList(String roomId){
		return changeDTOlist(myPageChatDAO.selectDanggunChatList(roomId));
	}
	
	public boolean insertMessage(DanggunChatMessageDTO danggunChatMessageDTO) {
		int result = myPageChatDAO.insertMessage(changeEntity(danggunChatMessageDTO));
		return (result > 0) ? true : false;
	}
	
	public boolean deleteMessage(Integer messageId) {
		int result = myPageChatDAO.deleteMessage(messageId);
		return (result > 0) ? true : false;
	}
	
	public int lastMessageId(String roomId) {
		return myPageChatDAO.lastMessageId(roomId);
	}
	
	public List<DanggunChatRoomDTO> changeDTORoomList(List<DanggunChatRoom> danggunChatRoom) {
		List<DanggunChatRoomDTO> changeList = new ArrayList<>();
		for (DanggunChatRoom data : danggunChatRoom) {
			changeList.add(changeRoomDTO(data));
		}
		return changeList;
	}
	
	private DanggunChatRoomDTO changeRoomDTO(DanggunChatRoom danggunChatRoom) {
		return DanggunChatRoomDTO.builder().roomId(danggunChatRoom.getRoomId())
				.danggunNumber(danggunChatRoom.getDanggunNumber()).seller(danggunChatRoom.getSeller())
				.buyer(danggunChatRoom.getBuyer()).build();
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
