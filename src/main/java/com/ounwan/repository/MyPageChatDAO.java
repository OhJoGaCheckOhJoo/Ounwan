package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.entity.Clients;
import com.ounwan.entity.DanggunChatMessage;
import com.ounwan.entity.DanggunChatRoom;

@Repository
public class MyPageChatDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.myPageChat.";
	
	public List<DanggunChatRoom> getchatList(String userId) {
		return sqlSession.selectList(NAMESPACE + "getchatList", userId);
		
	}
	
	public Clients getPartnerInfo(String buyer) {
		return sqlSession.selectOne(NAMESPACE + "getPartnerInfo", buyer);
	}

	public List<DanggunChatMessage> selectDanggunChatList(String roomId) {
		return sqlSession.selectList(NAMESPACE + "selectDanggunChatList", roomId);
	}
	
	// 방 여부 확인
	public List<String> selectRoomList(){
		return sqlSession.selectList(NAMESPACE + "selectRoomList");
	}

	// 방 없으면 만들기
	public int makeRoom(DanggunChatRoom makeChatRoom) {
		return sqlSession.insert(NAMESPACE + "makeRoom", makeChatRoom);
	}

	public int insertMessage(DanggunChatMessage danggunChatMessage) {
		return sqlSession.insert(NAMESPACE + "insertMessage", danggunChatMessage);
	}

	public int deleteMessage(Integer messageId) {
		return sqlSession.delete(NAMESPACE + "deleteMessage", messageId);
	}
	
	public int lastMessageId(String roomId) {
		return sqlSession.selectOne(NAMESPACE + "lastMessageId", roomId);
	}

	public int selectDanggunNumber(String roomId) {
		return sqlSession.selectOne(NAMESPACE + "selectDanggunNumber", roomId);
	}
	
}
