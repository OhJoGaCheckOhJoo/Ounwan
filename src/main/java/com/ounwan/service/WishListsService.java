package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.repository.WishListsDAO;

@Service
public class WishListsService {
	@Autowired
	WishListsDAO wishListsDAO;
	
	public int selectCountZzim(int num) {
		return wishListsDAO.selectCountZzim(num);
	}
}
