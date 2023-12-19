package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.CoupungDTO;
import com.ounwan.dto.CoupungOptionsDTO;
import com.ounwan.entity.CoupungOptions;
import com.ounwan.repository.CoupungOptionsDAO;

@Service
public class CoupungOptionsService {
	
	@Autowired
	CoupungOptionsDAO coupungOptionsDAO;
	
	public List<CoupungOptionsDTO> selectOptions (int coupungId) {
		return changeListDTO(coupungOptionsDAO.selectOptions(coupungId));
	}

	public List<CoupungOptionsDTO> getOptionByOptionId(int optionNumber) {
		return changeListDTO(coupungOptionsDAO.getOptionByOptionId(optionNumber));
	}
	
	public List<CoupungOptionsDTO> changeListDTO(List<CoupungOptions> optionList) {
		List<CoupungOptionsDTO> options = new ArrayList<CoupungOptionsDTO>();
		for (CoupungOptions option : optionList) {
			options.add(changeDTO(option));
		}
		return options;
	}

	public CoupungOptionsDTO changeDTO (CoupungOptions option) {
		return CoupungOptionsDTO.builder()
								.coupungOptionNumber(option.getCoupungOptionNumber())
								.coupungNumber(option.getCoupungNumber())
								.name(option.getName())
								.build();
	}
}
