package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.dto.OrderDetailsDTO;

@Repository
public class OrderDetailDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.orderDetail.";

	public int setOrder(OrderDetailsDTO product) {
		return sqlSession.insert(NAMESPACE + "setOrder", product);
	}

}
