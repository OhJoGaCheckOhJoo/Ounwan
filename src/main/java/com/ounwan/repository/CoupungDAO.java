package com.ounwan.repository;

import java.util.List;

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
}
