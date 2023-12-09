package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.ProductImages;

@Repository
public class ProductImageDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.productImage.";
	
	public ProductImages getImageByCoupungId(Integer coupungProductId) {
		return sqlSession.selectOne(NAMESPACE + "selectByCoupungId" + coupungProductId);
	}
}
