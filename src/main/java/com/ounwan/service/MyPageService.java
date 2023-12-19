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

	public List<Map<String, Object>> getDanggunSaleList(String userId) {
		return myPageDAO.getDanggunSaleList(userId);
	}
	
	public List<Map<String, Object>> getDanggunWishList(String userId) {
		return myPageDAO.getDanggunWishList(userId);
		
	}
	
	public List<AetaDTO> getAetaList(String userId) {		
		return  changeDTOList(myPageDAO.getAetaList(userId));
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
				.boardNumber(aeta.getBoardNumber())
				.title(aeta.getTitle())
				.contents(aeta.getContents())
				.clientId(aeta.getClientId())
				.createdDate(aeta.getCreatedDate())
				.updatedDate(aeta.getCreatedDate())
				.views(aeta.getViews())
				.build();
	}
}
