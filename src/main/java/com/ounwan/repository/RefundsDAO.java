package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Refunds;

@Repository
public class RefundsDAO {

	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.myPage.";
	
	public int orderRefund(Refunds refund) {
		return sqlSession.insert(NAMESPACE + "refundOrder", refund);
	}
}
