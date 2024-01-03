package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Admin;

@Repository
public class AdminDAO {
	
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.admin.";

	public Admin checkAuthorization(String adminId) {
		return sqlSession.selectOne(NAMESPACE + "checkAuthorization", adminId);
	}
	
	public List<Map<String, Object>> getTotalPriceByDate() {
		return sqlSession.selectList(NAMESPACE + "selectTotalPriceByDate");
	}
	
	public List<Map<String, Object>> getCommunityAct() {
		return sqlSession.selectList(NAMESPACE + "selectCommunityAct");
	}
	
	public List<Map<String, Object>> getTotalByCategory() {
		return sqlSession.selectList(NAMESPACE + "selectTotalByCategory");
	}
	
	public List<Map<String, Object>> getDanggunTotal() {
		return sqlSession.selectList(NAMESPACE + "selectDanggunTotal");
	}
	
	public List<Map<String, Object>> getReportTotal() {
		return sqlSession.selectList(NAMESPACE + "selectReportTotal");
	}
}	
