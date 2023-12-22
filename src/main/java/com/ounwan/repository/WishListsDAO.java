package com.ounwan.repository;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.WishLists;

@Repository
public class WishListsDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.danggun.";

	public int selectCountZzim(int num) {
		return sqlSession.selectOne(NAMESPACE + "selectCountZzim", num);
	}
	
	public List<Integer> hasZzim(String clientId) {
		return sqlSession.selectList(NAMESPACE + "hasZzim", clientId);
	}

	public int plusZzim(WishLists wishLists) {
		return sqlSession.insert(NAMESPACE + "plusZzim", wishLists);
	}
	
	public int minusZzim(WishLists wishLists) {
		return sqlSession.delete(NAMESPACE + "minusZzim", wishLists);
	}
	
	
}
