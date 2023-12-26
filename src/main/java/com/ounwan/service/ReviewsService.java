package com.ounwan.service;

import java.io.File;
import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.entity.Reviews;
import com.ounwan.repository.ReviewsDAO;

@Service
public class ReviewsService {
	@Autowired
	ReviewsDAO reviewDAO;

	private final static String UPLOADPATH = "C:/Users/diana/OneDrive/문서/GitHub/Back-end/src/main/webapp/resources";
	private final static String REVIEWIMAGEPATH = "/images/reviews/";
	
	public boolean writeReview(MultipartFile reviewImage, int reviewDetailNumber, Double reviewScore,
			String reviewContent) throws IllegalStateException, IOException {
		int result=0;
		Reviews review;
		File file;
		
		if(reviewImage!= null) {
			String newFileName = reviewDetailNumber + "_" + System.currentTimeMillis() + "." + reviewImage.getContentType().split("/")[1];
			file = new File(UPLOADPATH + REVIEWIMAGEPATH + newFileName);
			review = Reviews.builder().orderDetailNumber(reviewDetailNumber).score(reviewScore).contents(reviewContent).ImageUrl("." + REVIEWIMAGEPATH + newFileName).build();

			result = reviewDAO.writeReview(review);
			if (result > 0) {
				reviewImage.transferTo(file);
			}
		
		}
		else {
			review = Reviews.builder().orderDetailNumber(reviewDetailNumber).score(reviewScore).contents(reviewContent).ImageUrl(null).build();
			result = reviewDAO.writeReview(review);
		}

		if(result > 0) {
			reviewDAO.changeReviewButton(reviewDetailNumber);
		}
				
		return result>0? true : false;
		
	}
	
}
