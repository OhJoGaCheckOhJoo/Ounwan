package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.StoreReportsDTO;
import com.ounwan.entity.StoreReports;
import com.ounwan.repository.StoreReportsDAO;

@Service
public class StoreReportsService {
	
	@Autowired
	StoreReportsDAO storeReportsDAO;
	
	@Autowired
	DanggunService danggunService;
	
	public boolean insertReport(StoreReportsDTO storeReports) {
		int confirmReport = storeReportsDAO.confirmReport(storeReports);
		if(confirmReport > 0) {
			return false;
		}
		int result = storeReportsDAO.insertReport(storeReports);
		int danggunNumber = storeReports.getDanggunNumber();
		
		int reportCount = storeReportsDAO.countReport(danggunNumber);
		if(reportCount >= 3) {
			danggunService.updateReport(danggunNumber);
		}
		return (result > 0) ? true : false;
	}
	
	public StoreReports changeEntity(StoreReportsDTO storeReports) {
		return StoreReports.builder()
							.storeReportNumber(storeReports.getStoreReportNumber())
							.reviewNumber(storeReports.getReviewNumber())
							.danggunNumber(storeReports.getDanggunNumber())
							.clientId(storeReports.getClientId())
							.registeredDate(storeReports.getRegisteredDate())
							.reason(storeReports.getReason())
							.category(storeReports.getCategory())
							.build();
	}
	
	public StoreReportsDTO changeDTO(StoreReports storeReports) {
		return StoreReportsDTO.builder()
								.storeReportNumber(storeReports.getStoreReportNumber())
								.reviewNumber(storeReports.getReviewNumber())
								.danggunNumber(storeReports.getDanggunNumber())
								.clientId(storeReports.getClientId())
								.registeredDate(storeReports.getRegisteredDate())
								.reason(storeReports.getReason())
								.category(storeReports.getCategory())
								.build();
	}
}
