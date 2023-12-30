package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.dto.OrdersDTO;
import com.ounwan.entity.Orders;

@Repository
public class OrderDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.order.";
	
	public List<Orders> getOrderList(String clientId) {
		return sqlSession.selectList(NAMESPACE + "selectList", clientId);
	}

	public int setOrder(Orders order) {
		return sqlSession.insert(NAMESPACE + "setOrder", order);
	}

	public List<Orders> getAdminOrderList() {
		return sqlSession.selectList(NAMESPACE + "selectAdminList");
	}

	public int updateTradeStatus(OrdersDTO order) {
		return sqlSession.update(NAMESPACE + "updateTradeStatus", order);
	}

	public Orders getOrderById(String orderNumber) {
		return sqlSession.selectOne(NAMESPACE + "getOrderById", orderNumber);
	}
}