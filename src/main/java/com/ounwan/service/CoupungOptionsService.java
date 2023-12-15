package com.ounwan.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.repository.CoupungOptionsDAO;

@Service
public class CoupungOptionsService {
	
	@Autowired
	CoupungOptionsDAO coupungOptionsDAO;
	
	public List<String> selectOptions (int coupungId) {
		return coupungOptionsDAO.selectOptions(coupungId);
	}

}
