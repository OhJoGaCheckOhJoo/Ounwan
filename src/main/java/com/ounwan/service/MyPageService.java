package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.DanggunDTO;
import com.ounwan.entity.Aeta;
import com.ounwan.entity.Danggun;
import com.ounwan.repository.MyPageDAO;

@Service
public class MyPageService {

	@Autowired
	MyPageDAO myPageDAO;
	
	public int getWishListCount(String userId) {
		return myPageDAO.getWishListCount(userId);
	}

	public int getCartListCount(String userId) {
		return myPageDAO.getCartListCount(userId);
	}
	
	public List<Map<String, Object>> orderListPreview(String userId) {
		return myPageDAO.getOrderPreviewList(userId);
	}

	public List<AetaDTO> aetaListPreview(String userId) {
		return changeDTOList(myPageDAO.getAetaPreviewList(userId));
	}

	public List<Map<String, Object>> cartListPreview(String userId) {
		return myPageDAO.getCartPreviewList(userId);
		
	}

	public List<Map<String, Object>> getDanggunSaleList(String userId) {
		return myPageDAO.getDanggunSaleList(userId);
	}
	
	public List<Map<String, Object>> getDanggunWishList(String userId) {
		return myPageDAO.getDanggunWishList(userId);
		
	}
	
	public boolean deleteWishList(List<String> selectWishLists) {
		int result = 0;
		
		for(String wishList: selectWishLists) {
			myPageDAO.deleteWishList(Integer.parseInt(wishList));
			result++;
		}
		return selectWishLists.size()==result? true: false;
	}
	
	public List<AetaDTO> getAetaList(String userId) {		
		return  changeDTOList(myPageDAO.getAetaList(userId));
	}
	
	public List<Map<String, Object>> getReviewList(String userId) {
		return myPageDAO.getReviewList(userId);
	}
	
	public boolean deleteReviewList(List<String> selectedReviews) {
		int result =0;
		for(String reviewNumber: selectedReviews) {
			myPageDAO.deleteReviewList(Integer.parseInt(reviewNumber));
			result++;
		}
		
		return selectedReviews.size()==result? true: false;
		
	}
	
	public DanggunDTO changeDTO(Danggun danggun) {
		return DanggunDTO.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}
	
	public List<AetaDTO> changeDTOList(List<Aeta> aeta){
        List<AetaDTO> changeList = new ArrayList<>();
        for(Aeta data : aeta) {
            changeList.add(changeDTO(data));
        }
        return changeList;
    }

	public AetaDTO changeDTO(Aeta aeta) {
		return AetaDTO
				.builder()
				.aetaNumber(aeta.getAetaNumber())
				.title(aeta.getTitle())
				.contents(aeta.getContents())
				.clientId(aeta.getClientId())
				.createdDate(aeta.getCreatedDate())
				.updatedDate(aeta.getCreatedDate())
				.views(aeta.getViews())
				.build();
	}

}
