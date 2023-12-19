package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Clients;

@Repository
public class MyPageDAO {
	

	private static final String NAMESPACE = "net.ounwan.myPage";
	
	@Autowired
	SqlSession sqlSession;
	
	public Clients getPasswordById(String clientId) {
		return sqlSession.selectOne(NAMESPACE + "getPasswordById", clientId);
	}

	public String getUserInfo(Clients client) {
		return sqlSession.selectOne(NAMESPACE + "getUserInfo", client);
	}
	
	public int modifyPwd(Clients client) {
		return sqlSession.update(NAMESPACE + "modifyPwd", client);
	}
	
	public int modifyUserInfo(Clients client) {
		return sqlSession.update(NAMESPACE + "modifyUserInfo", client);
	}

	

}
