package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.ProductImages;

@Repository
public class ProductImagesDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.danggun.";
	
	public List<ProductImages> selectImages(int danggunNumber) {
		return sqlSession.selectList(NAMESPACE + "selectImages", danggunNumber);
	}
	
	
}
