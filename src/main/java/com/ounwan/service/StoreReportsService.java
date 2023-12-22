package com.ounwan.service;

import org.springframework.stereotype.Service;

import com.ounwan.dto.StoreReportsDTO;
import com.ounwan.entity.StoreReports;

@Service
public class StoreReportsService {
	
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
