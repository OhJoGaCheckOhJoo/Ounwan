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
	public List<Danggun> paginatedlist(Map<Object, Object> paginateParams ) {
		return sqlSession.selectList(NAMESPACE + "paginatedlist",paginateParams);
	}
	
	public int countProducts(String inputValue) {
		return sqlSession.selectOne(NAMESPACE+"countProducts",inputValue);
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

	public int updateReport(int danggunNumber) {
		return sqlSession.update(NAMESPACE + "updateReport", danggunNumber);
	}

	public List<Danggun> getTopFiveDanggun() {
		return sqlSession.selectList(NAMESPACE + "getTopFiveDanggun");
	}

	public String getMainImage(int danggunNumber) {
		return sqlSession.selectOne(NAMESPACE + "getMainImage", danggunNumber);
	}

	public List<Danggun> getDanggunReportList() {
		return sqlSession.selectList(NAMESPACE + "getDanggunReportList");
	}

	public int restoreDanggun(Integer danggunNumber) {
		return sqlSession.update(NAMESPACE + "restoreDanggun", danggunNumber);
	}
	public int adminDanggunDelete(int danggunNumber) {
		return sqlSession.update(NAMESPACE + "adminDanggunDelete", danggunNumber);
	}
	
}
