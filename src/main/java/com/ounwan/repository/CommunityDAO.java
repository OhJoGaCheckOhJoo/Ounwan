package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.OunwanGram;

@Repository
public class CommunityDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.community.";

	public List<OunwanGram> gramFollowBoard(Map<String, Object> dataMap) {
		return sqlSession.selectList(NAMESPACE + "gramFollowBoard", dataMap);
	}

	public List<OunwanGram> gramWholeBoard(int rowNum) {
		return sqlSession.selectList(NAMESPACE + "gramWholeBoard", rowNum);
	}
	
}
