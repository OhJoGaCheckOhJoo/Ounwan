package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Orders;

@Repository
public class OrderDAO {
	
	@Autowired
	SqlSession session;
	private static final String NAMESPACE = "net.ounwan.order.";
	
	public List<Orders> getOrderList(String clientId) {
		return session.selectList(NAMESPACE + "selectList", clientId);
	}
}