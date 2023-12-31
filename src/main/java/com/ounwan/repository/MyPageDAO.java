package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Aeta;
import com.ounwan.entity.Clients;
import com.ounwan.entity.DanggunChatRoom;

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
		return sqlSession.selectList(NAMESPACE + "coupungOrderList", userId);
	}
	
	public int changeConfirmState(String orderNumber) {
		return sqlSession.update(NAMESPACE + "changeConfirmState", orderNumber);
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

	public List<Aeta> getAetaList(Map<String,Object> userPosts) {
		return sqlSession.selectList(NAMESPACE + "aetaList", userPosts);
	}	
	public int countAetaList(String userId) {
		return sqlSession.selectOne(NAMESPACE + "countAetaList", userId);
	}
	
	public List<Map<String, Object>> getReviewList(String userId) {
		return sqlSession.selectList(NAMESPACE + "reviewList", userId);
	}

	public int deleteReviewList(int reviewNumber) {
		return sqlSession.delete(NAMESPACE + "deleteReview", reviewNumber);
	}
	
	public String getPwdById(String clientId) {
	    return sqlSession.selectOne(NAMESPACE + "getPwdById", clientId);
	}

	public Clients getUserInfo(String clientId) {
		return sqlSession.selectOne(NAMESPACE + "getUserInfo", clientId);
	}	

	public int modifyPwd(Clients client) {
		return sqlSession.update(NAMESPACE + "modifyPwd", client);
	}
		
	public int modifyUserInfo(Clients client) {
		return sqlSession.update(NAMESPACE + "modifyUserInfo", client);
	}

	public int modifyProfileURL(Clients client) {
		return sqlSession.update(NAMESPACE + "modifyProfileURL", client);
	}
	
	public int withdrawUserInfo(Clients client) {
		return sqlSession.update(NAMESPACE + "withdrawUserInfo", client);
	}

}
