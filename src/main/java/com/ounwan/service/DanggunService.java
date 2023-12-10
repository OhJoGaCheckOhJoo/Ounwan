package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.entity.Danggun;
import com.ounwan.repository.DanggunDAO;

@Service
public class DanggunService {
	
	@Autowired
	DanggunDAO danggunDAO;
	
	public List<DanggunDTO> searchProduct(String name) {
		List<DanggunDTO> searchList = new ArrayList<DanggunDTO>();
		for(Danggun danggun : danggunDAO.searchProduct(name)) {
			searchList.add(changeDTO(danggun));
		}		
		return searchList;
	}

	public List<DanggunDTO> listAll() {		
		List<DanggunDTO> list = new ArrayList<>();
		for(Danggun danggun: danggunDAO.listAll()) {
			list.add(changeDTO(danggun));
		}		
		return list;
	}
	
	public Danggun changeEntity(DanggunDTO danggun) {
		return Danggun.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}
	
	public DanggunDTO changeDTO(Danggun danggun) {
		return DanggunDTO.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}

}
