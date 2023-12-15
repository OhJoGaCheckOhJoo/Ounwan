package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class WishListsDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.danggun.";

	public int selectCountZzim(int num) {
		return sqlSession.selectOne(NAMESPACE + "selectCountZzim", num);
	}

}
