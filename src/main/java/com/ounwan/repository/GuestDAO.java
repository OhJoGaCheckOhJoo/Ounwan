package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Guests;

@Repository
public class GuestDAO {
	
	@Autowired
	SqlSession sqlSession;
	private static final String NAMESPACE = "net.ounwan.guest.";
	
	public int addGuestInfo(Guests guest) {
		return sqlSession.insert(NAMESPACE + "addGuest", guest);
	}

}
