package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Admin;

@Repository
public class AdminDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.admin.";

	public Admin checkAuthorization(String adminId) {
		return sqlSession.selectOne(NAMESPACE + "checkAuthorization", adminId);
	}	
}	
