package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.ProductImages;

@Repository
public class ProductImagesDAO {
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.myPage.";

	public ProductImages getSaleImage(int danggunNumber) {
		return sqlSession.selectOne(NAMESPACE + "imageSaleList", danggunNumber);
	}	
	
}
