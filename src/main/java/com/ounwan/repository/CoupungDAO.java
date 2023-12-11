package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Coupung;

@Repository
public class CoupungDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.coupung.";
	
	public Coupung getById(int coupungId) {
		return sqlSession.selectOne(NAMESPACE + "getById", coupungId);
	}
}
