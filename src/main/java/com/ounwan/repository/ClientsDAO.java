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
	public int checkId(String checkId ) {
		return sqlSession.selectOne(NAMESPACE + "checkClientId", checkId);
	}
	public int checkEmail(String email) {
		return sqlSession.selectOne(NAMESPACE + "checkEmail", email);
	}
  
	public Clients findClientId(Clients client) {
		return sqlSession.selectOne(NAMESPACE + "selectForFindId", client);
	}
	
	public int findPassword(Clients client) {
		return sqlSession.selectOne(NAMESPACE + "selectForFindPassword", client);
	}

	public int updateRandomPassword(Clients client) {
		return sqlSession.update(NAMESPACE + "updatePassword", client);
	}

	public int withdrawalClient(Clients client) {
		return sqlSession.update(NAMESPACE + "withdrawal", client);
	}

	public Clients checkLogin(String id) {
		return sqlSession.selectOne(NAMESPACE + "checkLogin", id);
	}

	public Clients checkNaverToken(String token) {
		return sqlSession.selectOne(NAMESPACE + "checkNaverToken", token);
	}

	public Clients checkKakaoToken(String token) {
		return sqlSession.selectOne(NAMESPACE + "checkKakaoToken", token);
	}
	
	public Clients checkGoogleToken(String token) {
		return sqlSession.selectOne(NAMESPACE + "checkGoogleToken", token);
	}
	
	public String getEmailAuth(String clientId) {
		return sqlSession.selectOne(NAMESPACE + "getEmailAuth", clientId);
	}
	
	public int updateActivation(String clientId) {
		return sqlSession.update(NAMESPACE + "updateActivation", clientId);
	}
}
