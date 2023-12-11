package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class TradeHistoryDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.danggun.";
	
	public String selectTradeStep(int num) {
		return sqlSession.selectOne(NAMESPACE + "selectTradeStep", num);
	}
	
}
