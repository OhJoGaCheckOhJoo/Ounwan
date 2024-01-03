package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	public int countOrders() {
		return sqlSession.selectOne(NAMESPACE + "countOrders");
	}

	public List<Integer> getTopFiveCoupungNumber() {
		return sqlSession.selectList(NAMESPACE + "getTopFive");
	}

	public List<OrderDetails> getOrderDetails(String orderNumber) {
		return sqlSession.selectList(NAMESPACE + "getOrderDetails", orderNumber);
	}
	
	public List<Map<String, Object>> getAdminOrders(int offset) {
		return sqlSession.selectList(NAMESPACE + "getAdminOrders", offset);
	}
	
	public List<Map<String, Object>> getTradeStep() {
		return sqlSession.selectList(NAMESPACE + "getTradeStep");
	}

	public int updateTradeStep(Map<String, Object> data) {
		return sqlSession.update(NAMESPACE + "updateTradeStep", data);
	}

}
