package com.ounwan.repository;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.FAQ;

@Repository
public class FAQDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.faq.";

	public List<FAQ> getFAQList(Map<String, Object> data) {
		return sqlSession.selectList(NAMESPACE + "getFAQList", data);
	}
	
	public int countFAQList(Map<String, Object> data) {
		return sqlSession.selectOne(NAMESPACE + "countFAQList", data);
	}

}
