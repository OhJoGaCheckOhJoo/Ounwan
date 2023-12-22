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

	public int getWishListCount(String userId) {
		return sqlSession.selectOne(NAMESPACE + "wishListCount", userId);
	}
	
	public int getCartListCount(String userId) {
		return sqlSession.selectOne(NAMESPACE + "cartListCount", userId); 
	}
	
	public List<Map<String, Object>> getOrderPreviewList(String userId) {
		return sqlSession.selectList(NAMESPACE + "orderPreviewList", userId);
	}
	
	public List<Aeta> getAetaPreviewList(String userId) {
		return sqlSession.selectList(NAMESPACE + "aetaPreviewList", userId);
	}
	
	public List<Map<String, Object>> getCartPreviewList(String userId) {
		return sqlSession.selectList(NAMESPACE + "cartPreviewList" , userId);
	}
	
	public List<Map<String, Object>> getCoupungOrderList(String userId) {
		// TODO Auto-generated method stub
		return sqlSession.selectList(NAMESPACE + "coupungOrderList", userId);
	}
	
	public List<Map<String, Object>> getDanggunSaleList(String userid){
		return sqlSession.selectList(NAMESPACE + "danggunSaleList", userid);
	}

	public List<Map<String, Object>> getDanggunWishList(String userId) {
		return sqlSession.selectList(NAMESPACE + "danggunWishList", userId);
	}
	
	public int deleteWishList(int wishListNumber) {
		return sqlSession.delete(NAMESPACE + "deleteWishList", wishListNumber);
	}

	public List<Aeta> getAetaList(String userId) {
		return sqlSession.selectList(NAMESPACE + "aetaList", userId);
	}
	
	public List<Map<String, Object>> getReviewList(String userId) {
		return sqlSession.selectList(NAMESPACE + "reviewList", userId);
	}

	public int deleteReviewList(int reviewNumber) {
		return sqlSession.delete(NAMESPACE + "deleteReview", reviewNumber);
	}

}
