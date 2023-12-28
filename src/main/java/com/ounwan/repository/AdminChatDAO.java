package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.SomsomiChatRoom;

@Repository
public class AdminChatDAO {
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.adminChat.";
	
	public List<SomsomiChatRoom> getSomsomiRoomList() {
		return sqlSession.selectList(NAMESPACE + "getSomsomiRoomList");
	}

}
