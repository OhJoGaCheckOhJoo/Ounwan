package com.ounwan.repository;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ounwan.entity.Reviews;

@Repository
public class ReviewsDAO {
	@Autowired
	SqlSession sqlSession;
	
	private static final String NAMESPACE = "net.ounwan.myPage.";

	public int writeReview(Reviews review) {
		return sqlSession.insert(NAMESPACE + "writeReview",review);		
	}

	public int changeReviewButton(int reviewDetailNumber) {
		return sqlSession.update(NAMESPACE + "disabledReviewButton", reviewDetailNumber);		
	}	
}
