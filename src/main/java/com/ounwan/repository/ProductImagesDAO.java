package com.ounwan.repository;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.ProductImages;

@Repository
public class ProductImagesDAO {
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.danggun.";

	public ProductImages selectAllImages(int danggunNumber) {
		return sqlSession.selectOne(NAMESPACE + "selectAllImage", danggunNumber);
	}

	public int imageInsert(Map<String, Object> data) {
		return sqlSession.insert(NAMESPACE + "imageInsert", data);
	}
}
