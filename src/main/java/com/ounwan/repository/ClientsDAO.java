package com.ounwan.repository;

import java.util.HashMap;
import java.util.Map;

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

	public Clients checkLogin(String id, String password) {
		Map<String, Object> mapData = new HashMap<>();
		mapData.put("clientId", id);
		mapData.put("password", password);
		return sqlSession.selectOne(NAMESPACE + "checkLogin", mapData);
	}

}
