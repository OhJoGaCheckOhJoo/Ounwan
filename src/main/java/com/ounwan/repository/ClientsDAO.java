package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Clients;

@Repository
public class ClientsDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.clients.";
	
	public int createAccount(Clients client) {
		return sqlSession.insert(NAMESPACE + "insertClient", client);
	}

	public String checkLogin(String id) {
		return sqlSession.selectOne(NAMESPACE + "checkLogin", id);
	}

	public Clients checkNaverToken(String token) {
		return sqlSession.selectOne(NAMESPACE + "checkNaverToken", token);
	}

	public Clients checkKakaoToken(String token) {
		return sqlSession.selectOne(NAMESPACE + "checkKakaoToken", token);
	}
	
}
