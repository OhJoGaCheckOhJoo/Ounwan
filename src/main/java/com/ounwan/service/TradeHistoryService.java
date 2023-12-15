package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.repository.TradeHistoryDAO;

@Service
public class TradeHistoryService {
	@Autowired
	TradeHistoryDAO tradeHistoryDAO;
	
	public String selectTradeStep(int num) {
		return tradeHistoryDAO.selectTradeStep(num);
	}
}
