package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Aeta;

@Repository
public class MyPageDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.myPage.";
	
	
	//main_최근 주문 내역 최대 3개
	public List<Map<String, Object>> getOrderPreviewList(String userId) {
		return sqlSession.selectList(NAMESPACE + "orderPreviewList", userId);
	}
	
	//main_최근 내가 쓴 게시글 최대 3개
	public List<Aeta> getAetaPreviewList(String userId) {
		return sqlSession.selectList(NAMESPACE + "aetaPreviewList", userId);
	}
	
	//main_최근 장바구니 내역 최대 3개
	public List<Map<String, Object>> getCartPreviewList(String userId) {
		return sqlSession.selectList(NAMESPACE + "cartPreviewList" , userId);
	}
	
	//danggun 판매 목록 조회
	public List<Map<String, Object>> getDanggunSaleList(String userid){
		return sqlSession.selectList(NAMESPACE + "danggunSaleList", userid);
	}

	//danggun 찜한 상품 목록 조회
	public List<Map<String, Object>> getDanggunWishList(String userId) {
		return sqlSession.selectList(NAMESPACE + "danggunWishList", userId);
	}

	//aeta 내가 쓴 게시글 목록 조회
	public List<Aeta> getAetaList(String userId) {
		return sqlSession.selectList(NAMESPACE + "aetaList", userId);
	}
	
	//coupung 내가 쓴 리뷰 목록 조회
	public List<Map<String, Object>> getReviewList(String userId) {
		return sqlSession.selectList(NAMESPACE + "reviewList", userId);
	}

}
