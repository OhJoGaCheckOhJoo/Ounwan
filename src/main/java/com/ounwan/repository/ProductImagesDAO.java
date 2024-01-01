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
		
	public ProductImages selectAllImages(int danggunNumber) {
		return sqlSession.selectOne(NAMESPACE + "selectAllImage", danggunNumber);
	}
	
	public int imageInsert(ProductImages image) {
		return sqlSession.insert(NAMESPACE + "imageInsert", image);
	}
	
	public List<ProductImages> selectImages(int danggunNumber) {
		return sqlSession.selectList(NAMESPACE + "selectImages", danggunNumber);
	}

	public int updateDanggunImages(ProductImages image) {
		return sqlSession.update(NAMESPACE + "updateDanggunImages", image);
	}
	
	public ProductImages getSaleImage(int danggunNumber) {
		return sqlSession.selectOne(NAMESPACE + "imageSaleList", danggunNumber);
	}	
	public int insertNewDetailImages(ProductImages image) {
		return sqlSession.insert(NAMESPACE + "insertNewDetailImages", image);
	}
}
