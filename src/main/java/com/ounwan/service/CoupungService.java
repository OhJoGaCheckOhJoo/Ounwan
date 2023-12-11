package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.CoupungDTO;
import com.ounwan.entity.Coupung;
import com.ounwan.repository.CoupungDAO;

@Service
public class CoupungService {

	@Autowired
	CoupungDAO coupungDAO;
	
	public CoupungDTO getById(int coupungNumber) {
		return changeDTO(coupungDAO.getById(coupungNumber));
	}
	
	public CoupungDTO changeDTO(Coupung coupung) {
		return CoupungDTO.builder()
							.coupungNumber(coupung.getCoupungNumber())
							.coupungCategoryNumber(coupung.getCoupungCategoryNumber())
							.name(coupung.getName())
							.price(coupung.getPrice())
							.availableCheck(coupung.isAvailableCheck())
							.availableStock(coupung.getAvailableStock())
							.option(coupung.getOption())
							.build();
	}
}
