package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Clients;

@Repository
public class MyPageDAO {
	

	private static final String NAMESPACE = "net.ounwan.myPage.";
	
	@Autowired
	SqlSession sqlSession;
	
	public String getPwdById(String clientId) {
		System.out.println("DAO왔다감");
	    return sqlSession.selectOne(NAMESPACE + "getPwdById", clientId);
	}

	public Clients getUserInfo(String clientId) {
		return sqlSession.selectOne(NAMESPACE + "getUserInfo", clientId);
	}
	

	public int modifyPwd(Clients client) {
		return sqlSession.update(NAMESPACE + "modifyPwd", client);
	}
	
	
	public int modifyUserInfo(Clients client) {
		return sqlSession.update(NAMESPACE + "modifyUserInfo", client);
	}

	

}
