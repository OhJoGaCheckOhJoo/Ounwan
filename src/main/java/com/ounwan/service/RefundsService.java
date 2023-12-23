package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.RefundsDTO;
import com.ounwan.entity.Refunds;
import com.ounwan.repository.RefundsDAO;

@Service
public class RefundsService {
	
	@Autowired
	RefundsDAO refundsDAO;
	
	public boolean orderRefund(RefundsDTO refund) {
		int result = refundsDAO.orderRefund(Refunds.builder().orderNumber(refund.getOrderNumber()).reason(refund.getReason()).build());
		
		return result > 0? true : false;
	}


}
