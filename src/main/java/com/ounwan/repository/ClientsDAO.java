package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.entity.Clients;

@Repository
public class ClientsDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.clients.";
	
	public int createAccount(Clients client) {
		return sqlSession.insert(NAMESPACE + "insertClient", client);
	}
	
	public Clients findClientId(Clients client) {
		return (Clients)sqlSession.selectOne(NAMESPACE + "selectForFindId", client);
	}
	
	public int findPassword(Clients client) {
		return sqlSession.selectOne(NAMESPACE + "selectForFindPassword", client);
	}

}
