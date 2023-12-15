package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.TradeHistoryDTO;
import com.ounwan.entity.TradeHistory;
import com.ounwan.repository.TradeHistoryDAO;

@Service
public class TradeHistoryService {
	@Autowired
	TradeHistoryDAO tradeHistoryDAO;
	
	public String selectTradeStep(int num) {
		return tradeHistoryDAO.selectTradeStep(num);
	}
	/*
	public TradeHistory changeEntity(TradeHistoryDTO tradeHistory) {
		return TradeHistory.builder()
							.tradeHistoryNUmber(tradeHistory.getTradeHistoryNUmber())
							.tradeStep(tradeHistory.getTradeStep())
							.build();
	}
	public TradeHistoryDTO changeDTO(TradeHistory tradeHistory) {
		return TradeHistoryDTO.builder()
								.tradeHistoryNUmber(tradeHistory.getTradeHistoryNUmber())
								.tradeStep(tradeHistory.getTradeStep())
								.build();
	}*/
}
