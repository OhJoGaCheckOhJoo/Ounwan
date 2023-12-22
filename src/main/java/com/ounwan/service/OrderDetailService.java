package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.OrderDetailsDTO;
import com.ounwan.repository.OrderDetailDAO;

@Service
public class OrderDetailService {
	
	@Autowired
	OrderDetailDAO orderDetailDAO;

	public boolean setOrder(OrderDetailsDTO product, String orderNumber) {
		product.setOrderNumber(orderNumber);
		int result = orderDetailDAO.setOrder(product);
		return (result > 0) ? true : false;
	}

}
