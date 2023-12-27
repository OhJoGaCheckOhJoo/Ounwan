package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.dto.OrderDetailsDTO;
import com.ounwan.entity.OrderDetails;

@Repository
public class OrderDetailDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.orderDetail.";

	public int setOrder(OrderDetails product) {
		return sqlSession.insert(NAMESPACE + "setOrder", product);
	}
	
	public int getSalesRate(int coupungNumber) {
		return sqlSession.selectOne(NAMESPACE + "getSalesRate", coupungNumber);
	}

	public List<Integer> getTopFiveCoupungNumber() {
		return sqlSession.selectList(NAMESPACE + "getTopFive");
	}

	public List<OrderDetailsDTO> getOrderDetails(String orderNumber) {
		return sqlSession.selectList(NAMESPACE + "getOrderDetails", orderNumber);
	}

}
