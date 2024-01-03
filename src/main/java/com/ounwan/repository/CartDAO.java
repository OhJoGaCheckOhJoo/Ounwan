package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Carts;

@Repository
public class CartDAO {

	@Autowired
	SqlSession sqlSession;

	private static final String NAMESPACE = "net.ounwan.carts.";

	public List<Map<String,Object>> getCartById(String clientId) {
		return sqlSession.selectList(NAMESPACE + "getCartById", clientId);
	}

	public Carts getQuantity(Carts cart) {
		return sqlSession.selectOne(NAMESPACE + "getQuantity",cart);
	}

	public int updateQuantity(Carts cart) {
		return sqlSession.update(NAMESPACE + "updateQuantity", cart);
	}
	
	public int insertCart(Carts cart) {
		return sqlSession.insert(NAMESPACE + "insertCart", cart);
	}
	
	public int updateCart(Carts cart) {
		return sqlSession.update(NAMESPACE + "updateCart", cart);
	}

	public int deleteCart(Carts cart) {
		return sqlSession.delete(NAMESPACE + "deleteCart", cart); 
	}
}
