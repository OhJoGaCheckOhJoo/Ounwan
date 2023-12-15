package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Danggun;

@Repository
public class DanggunDAO {

	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.danggun.";
	
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
