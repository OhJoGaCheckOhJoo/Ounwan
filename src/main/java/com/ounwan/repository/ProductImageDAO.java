package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.ProductImages;

@Repository
public class ProductImageDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.productImage.";
	
	public List<ProductImages> getProductImageByCoupungId(Integer coupungProductId) {
		return sqlSession.selectList(NAMESPACE + "selectProductImageByCoupungId", coupungProductId);
	}
	
	public List<ProductImages> getDetailImageByCoupungId(Integer coupungProductId) {
		return sqlSession.selectList(NAMESPACE + "selectDetailImageByCoupungId", coupungProductId);
	}

	public int insertImage(ProductImages image) {
		return sqlSession.insert(NAMESPACE + "insertCoupungImage", image);
	}
}
