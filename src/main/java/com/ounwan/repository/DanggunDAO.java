package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

	public int danggunInsert(Danggun danggun) {
		sqlSession.insert(NAMESPACE + "danggunInsert", danggun);		
		return danggun.getDanggunNumber();
	}
	
	public Danggun selectDanggun(int danggunNumber) {
		return sqlSession.selectOne(NAMESPACE + "selectDanggun", danggunNumber);
	}

	public int deleteDanggun(Danggun danggun) {
		return sqlSession.delete(NAMESPACE + "deleteDanggun", danggun);
	}

	public int updateDanggun(Danggun danggun) {
		return sqlSession.update(NAMESPACE + "updateDanggun", danggun);
	}
	
}
