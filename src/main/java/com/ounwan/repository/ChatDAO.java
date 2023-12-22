package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Chat;

@Repository
public class ChatDAO {

	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.chat.";
	
	public List<Chat> selectChatList(){
		return sqlSession.selectList(NAMESPACE + "selectChatList");
	}
	
	public int insertMessage(Chat chat) {
		return sqlSession.insert(NAMESPACE + "insertMessage", chat);
	}
}
