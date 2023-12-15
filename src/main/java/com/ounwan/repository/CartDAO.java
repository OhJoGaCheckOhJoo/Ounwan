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

	public List<Map<Object,Object>> getCartById(String clientId) {
		List<Map<Object,Object>> cartlist = sqlSession.selectList(NAMESPACE + "getCartById", clientId);
		System.out.println(cartlist);
		return cartlist;
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
		int result = sqlSession.update(NAMESPACE + "updateCart", cart);
		System.out.println("result : " + result);
		return result;
	}

	public int deleteCart(Carts cart) {
		int result =sqlSession.delete(NAMESPACE + "deleteCart", cart); 
		System.out.println(" delete result : " + result);
		return result;
	}



	

}
