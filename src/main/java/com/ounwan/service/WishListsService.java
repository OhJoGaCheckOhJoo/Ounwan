package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.WishListsDTO;
import com.ounwan.entity.WishLists;
import com.ounwan.repository.WishListsDAO;

@Service
public class WishListsService {
	@Autowired
	WishListsDAO wishListsDAO;
	
	public int selectCountZzim(int num) {
		return wishListsDAO.selectCountZzim(num);
	}
	
	public WishLists changeEntity(WishListsDTO wishLists) {
		return WishLists.builder()
							.wishListNumber(wishLists.getWishListNumber())
							.danggunNumber(wishLists.getDanggunNumber())
							.clientId(wishLists.getClientId())
							.build();
	}
	public WishListsDTO changeDTO(WishLists wishLists) {
		return WishListsDTO.builder()
							.wishListNumber(wishLists.getWishListNumber())
							.danggunNumber(wishLists.getDanggunNumber())
							.clientId(wishLists.getClientId())
							.build();
	}
}
