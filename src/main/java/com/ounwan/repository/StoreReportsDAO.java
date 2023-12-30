package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.dto.StoreReportsDTO;

@Repository
public class StoreReportsDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.danggun.";
	
	public int insertReport(StoreReportsDTO storeReports) {
		return sqlSession.insert(NAMESPACE + "insertReport", storeReports);
	}

	public int countReport(Integer danggunNumber) {
		return sqlSession.selectOne(NAMESPACE+"countReport", danggunNumber);
	}

	public int confirmReport(StoreReportsDTO storeReports) {
		return sqlSession.selectOne(NAMESPACE + "confirmReport", storeReports);
	}
}
