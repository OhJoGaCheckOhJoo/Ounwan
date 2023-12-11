package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.entity.Danggun;
import com.ounwan.repository.DanggunDAO;


@Service
public class DanggunService {

	@Autowired
	DanggunDAO danggunDAO;
	
	public DanggunDTO selectDanggun(int danggunNumber) {
		Danggun result = danggunDAO.selectDanggun(danggunNumber);
		return (result != null) ? changeDTO(result) : null;
	}
	
	public int deleteDanggun(DanggunDTO danggun) {
		int result = danggunDAO.deleteDanggun(changeEntity(danggun));
		return (result > 0) ? 1 : 0;
	}
	
	public Danggun changeEntity(DanggunDTO danggun) {
		return Danggun.builder()
						.danggunNumber(danggun.getDanggunNumber())
						.tradeHistoryNumber(danggun.getTradeHistoryNumber())
						.clientId(danggun.getClientId())
						.name(danggun.getName())
						.price(danggun.getPrice())
						.detail(danggun.getDetail())
						.uploadDate(danggun.getUploadDate())
						.build();
	}
	
	public DanggunDTO changeDTO(Danggun danggun) {
		return DanggunDTO.builder()
					.danggunNumber(danggun.getDanggunNumber())
					.tradeHistoryNumber(danggun.getTradeHistoryNumber())
					.clientId(danggun.getClientId())
					.name(danggun.getName())
					.price(danggun.getPrice())
					.detail(danggun.getDetail())
					.uploadDate(danggun.getUploadDate())
					.build();
	}

}
