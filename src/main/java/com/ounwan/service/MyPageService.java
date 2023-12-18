package com.ounwan.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.entity.Danggun;
import com.ounwan.repository.MyPageDAO;

@Service
public class MyPageService {

	@Autowired
	MyPageDAO myPageDAO;

	public List<Map<String, Object>> getDanggunSaleList(String userId) {
		return myPageDAO.getDanggunSaleList(userId);
	}
	
	public List<Map<String, Object>> getDanggunWishList(String userId) {
		return myPageDAO.getDanggunWishList(userId);
		
	}
	
	public DanggunDTO changeDTO(Danggun danggun) {
		return DanggunDTO.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}
}
