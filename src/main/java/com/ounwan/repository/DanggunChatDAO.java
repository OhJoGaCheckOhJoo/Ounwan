package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.DanggunChatMessage;
import com.ounwan.entity.DanggunChatRoom;

@Repository
public class DanggunChatDAO {

	@Autowired
	SqlSession sqlSession;

	private static final String NAMESPACE = "net.ounwan.danggunChat.";

	public List<DanggunChatMessage> selectDanggunChatList(String roomId) {
		return sqlSession.selectList(NAMESPACE + "selectDanggunChatList", roomId);
	}
	
	public List<String> selectRoomList(){
		return sqlSession.selectList(NAMESPACE + "selectRoomList");
	}

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

}
