package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.entity.Danggun;

@Repository
public class DanggunDAO {

	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.danggun.";

	public List<Danggun> listAll() {
		return sqlSession.selectList(NAMESPACE + "selectAll");
	}
	
	public List<Danggun> searchProduct(String name) {
		return sqlSession.selectList(NAMESPACE + "searchProduct", name);
	}

}
