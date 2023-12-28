package com.ounwan.service;

import java.io.IOException;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.ounwan.entity.Reviews;
import com.ounwan.repository.ReviewsDAO;

@Service
public class ReviewsService {
	@Autowired
	ReviewsDAO reviewDAO;
	
	@Autowired
	AmazonS3 amazonS3;
	
	private static final String BUCKET = "ounwan";
	
	public boolean writeReview(MultipartFile reviewImage, int reviewDetailNumber, Double reviewScore,
			String reviewContent) throws IllegalStateException, IOException {
		int result=0;
		
		if(reviewImage!= null) {
			String newFileName = reviewDetailNumber + "_" + System.currentTimeMillis() + "." + reviewImage.getContentType().split("/")[1];
			
			ObjectMetadata metadata = new ObjectMetadata();
			metadata.setContentLength(reviewImage.getSize());
			metadata.setContentType(reviewImage.getContentType());
			
			amazonS3.putObject(BUCKET, newFileName, reviewImage.getInputStream(), metadata);
			
			String url = amazonS3.getUrl(BUCKET, newFileName).toString();

			result = reviewDAO.writeReview(Reviews.builder()
													.orderDetailNumber(reviewDetailNumber)
													.score(reviewScore)
													.contents(reviewContent)
													.ImageUrl(url)
													.build());
		}
		else {
			result = reviewDAO.writeReview(Reviews.builder()
													.orderDetailNumber(reviewDetailNumber)
													.score(reviewScore)
													.contents(reviewContent)
													.build());
		}
		if(result > 0) {
			reviewDAO.changeReviewButton(reviewDetailNumber);
		}
		return result>0? true : false;
	}
	
}
