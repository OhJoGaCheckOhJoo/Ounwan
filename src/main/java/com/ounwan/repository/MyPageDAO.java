package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class MyPageDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.myPage.";

	//danggun 판매 목록 조회
	public List<Map<String, Object>> getDanggunSaleList(String userid){
		return sqlSession.selectList(NAMESPACE + "danggunSaleList", userid);
	}

	//danggun 찜한 상품 목록 조회
	public List<Map<String, Object>> getDanggunWishList(String userId) {
		return sqlSession.selectList(NAMESPACE + "danggunWishList", userId);
	}
}
