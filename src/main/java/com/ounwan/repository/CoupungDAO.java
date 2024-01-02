package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Coupung;

@Repository
public class CoupungDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.coupung.";
	
	public List<Coupung> getProductList() {
		return sqlSession.selectList(NAMESPACE + "selectAll");
	}

	public List<Coupung> getAdminProductList(Map<String, Object> data) {
		return sqlSession.selectList(NAMESPACE + "selectAdminAll", data);
	}
	
	public String getProductCategory(int categoryId) {
		return sqlSession.selectOne(NAMESPACE + "selectProductCategory", categoryId);
	}
	
	public int getProductCount(Map<String, Object> data) {
		return sqlSession.selectOne(NAMESPACE + "selectProductCount", data);
	}
	
	public List<Coupung> getProductListById(int categoryId) {
		return sqlSession.selectList(NAMESPACE + "selectById", categoryId);
	}

	public Coupung getProductDetail(int coupungId) {
		return sqlSession.selectOne(NAMESPACE + "selectDetail", coupungId);
	}

	public List<Coupung> getHotDealProductList() {
		return sqlSession.selectList(NAMESPACE + "selectHotDeals");
	}

	public List<Coupung> findByName(String text) {
		return sqlSession.selectList(NAMESPACE + "findByName", text);
	}

	public int insertProduct(Coupung product) {
		return sqlSession.insert(NAMESPACE + "insertProduct",product);
	}

	public int updateProduct(Coupung product) {
		return sqlSession.update(NAMESPACE + "updateProduct", product);
	}

	public int deleteProduct(int coupungNumber) {
		return sqlSession.update(NAMESPACE + "deleteProduct", coupungNumber);
	}

	public int getPrice(int coupungNumber) {
		return sqlSession.selectOne(NAMESPACE + "getPrice", coupungNumber);
	}
	
	public List<Map<String, Object>> getReviewList(int coupungNumber) {
		return sqlSession.selectList(NAMESPACE + "selectReview", coupungNumber);
	}

	public Integer getScoreList(Map<String, Object> scoreInfo) {
		return sqlSession.selectOne(NAMESPACE + "getScoreList", scoreInfo);
	}

	public int getAvailableStock(int coupungNumber) {
		return sqlSession.selectOne(NAMESPACE + "getAvailableStock", coupungNumber);
	}
	
	public int updateAvailableStock(Coupung product) {
		return sqlSession.selectOne(NAMESPACE + "updateAvailableStock", product);
	}
	
	public List<Map<String, Object>> selectAllCategories() {
		return sqlSession.selectList(NAMESPACE + "selectAllCategories");
	}
}
