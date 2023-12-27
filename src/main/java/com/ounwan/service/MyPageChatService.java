package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.DanggunChatMessageDTO;
import com.ounwan.dto.DanggunChatRoomDTO;
import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.entity.Clients;
import com.ounwan.entity.Danggun;
import com.ounwan.entity.DanggunChatMessage;
import com.ounwan.entity.DanggunChatRoom;
import com.ounwan.repository.ClientsDAO;
import com.ounwan.repository.DanggunDAO;
import com.ounwan.repository.MyPageChatDAO;
import com.ounwan.repository.TradeHistoryDAO;

@Service
public class MyPageChatService {

	@Autowired
	MyPageChatDAO myPageChatDAO;

	@Autowired
	ClientsDAO clientsDAO;
	
	@Autowired
	DanggunDAO danggunDAO;
	
	@Autowired
	TradeHistoryDAO tradeHistoryDAO;
	
	@Autowired
	ProductImagesService productImageService;

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
		int result = myPageChatDAO.insertMessage(changeMessageEntity(danggunChatMessageDTO));
		return (result > 0) ? true : false;
	}
	
	public boolean deleteMessage(Integer messageId) {
		int result = myPageChatDAO.deleteMessage(messageId);
		return (result > 0) ? true : false;
	}
	
	public int lastMessageId(String roomId) {
		return myPageChatDAO.lastMessageId(roomId);
	}
	
	public DanggunDTO selectDanggun(String roomId) {
		int danggunNumber = myPageChatDAO.selectDanggunNumber(roomId);
		
		Danggun resultDanggun = danggunDAO.selectDanggun(danggunNumber);
//		여기서 danggun 결과, tradeHistoryNumber로 거래 결과 나오고, danggunNumber로 이미지랑 찜 리스트 가져오기 
		DanggunDTO danggun = null;
		if(resultDanggun != null) {
			danggun = changeDTO(resultDanggun);
			int tradeHistoryNumber = danggun.getTradeHistoryNumber();
			String tradeStep = tradeHistoryDAO.selectTradeStep(tradeHistoryNumber);
			danggun.setTradeStep(tradeStep);
		}
		
		List<ProductImagesDTO> resultImages = productImageService.selectImages(danggunNumber);
		if (resultImages != null) {
			danggun.setProductImagesList(resultImages);
		}

		return danggun;
	}
	
	public Danggun changeEntity(DanggunDTO danggun) {
		return Danggun.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).visibility(danggun.getVisibility()).build();
	}

	public DanggunDTO changeDTO(Danggun danggun) {
		return DanggunDTO.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).visibility(danggun.getVisibility()).build();
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
			changeList.add(changeMessageDTO(p));
		}
		return changeList;
	}
	
	
	public DanggunChatMessageDTO changeMessageDTO(DanggunChatMessage danggunChat) {
		return DanggunChatMessageDTO.builder()
				.messageId(danggunChat.getMessageId())
				.roomId(danggunChat.getRoomId())
				.sender(danggunChat.getSender())
				.message(danggunChat.getMessage())
				.regdate(danggunChat.getRegdate())
				.build();
	}
	
	public DanggunChatMessage changeMessageEntity(DanggunChatMessageDTO danggunChat) {
		return DanggunChatMessage.builder()
				.messageId(danggunChat.getMessageId())
				.roomId(danggunChat.getRoomId())
				.sender(danggunChat.getSender())
				.message(danggunChat.getMessage())
				.regdate(danggunChat.getRegdate())
				.build();
	}

}
