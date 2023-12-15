package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class CoupungOptionsDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.coupungOption.";
	
	public List<String> selectOptions (int coupungNumber) {
		return sqlSession.selectList(NAMESPACE + "selectOptions", coupungNumber);
	}
}
