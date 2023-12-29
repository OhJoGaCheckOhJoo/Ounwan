package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.SomsomiChatMessage;
import com.ounwan.entity.SomsomiChatRoom;

@Repository
public class SomsomiChatDAO {

	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.somsomiChat.";
	
	public List<String> selectRoomList(){
		return sqlSession.selectList(NAMESPACE + "selectRoomList");
	}
	
	public int makeRoom(SomsomiChatRoom makeChatRoom) {
		return sqlSession.insert(NAMESPACE + "makeRoom", makeChatRoom);
	}
	
	public List<SomsomiChatMessage> selectSomsomiChatList(String roomId){
		return sqlSession.selectList(NAMESPACE + "selectSomsomiChatList", roomId);
	}
	
	public int insertMessage(SomsomiChatMessage chat) {
		return sqlSession.insert(NAMESPACE + "insertMessage", chat);
	}

	public int lastMessageId(String roomId) {
		return sqlSession.selectOne(NAMESPACE + "lastMessageId", roomId);
	}

	public int deleteMessage(Integer messageId) {
		return sqlSession.delete(NAMESPACE + "deleteMessage", messageId);
	}
	
	public int selectResolvedStatus(String roomId) {
		return sqlSession.selectOne(NAMESPACE + "selectResolvedStatus", roomId);
	}

	public int updateResolvedStatus(String roomId) {
		return sqlSession.update(NAMESPACE + "updateResolvedStatus", roomId);
	}

}
