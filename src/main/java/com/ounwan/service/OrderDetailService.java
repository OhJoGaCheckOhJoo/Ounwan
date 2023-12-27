package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.OrderDetailsDTO;
import com.ounwan.entity.OrderDetails;
import com.ounwan.repository.OrderDetailDAO;

@Service
public class OrderDetailService {
	
	@Autowired
	OrderDetailDAO orderDetailDAO;
	
	@Autowired
	CoupungService coupungService;

	public boolean setOrder(OrderDetailsDTO product, String orderNumber) {
		product.setOrderNumber(orderNumber);
		int result = orderDetailDAO.setOrder(changeEntity(product));
		return (result > 0) ? true : false;
	}
	
	public int getSalesRate(int coupungNumber) {
		return orderDetailDAO.getSalesRate(coupungNumber);
	}

	public List<Integer> getTopFiveCoupungNumber() {
		return orderDetailDAO.getTopFiveCoupungNumber();
	}

	public List<OrderDetailsDTO> getOrderDetails(String orderNumber) {
		List<OrderDetailsDTO> orderList = orderDetailDAO.getOrderDetails(orderNumber);
		
		for (OrderDetailsDTO order : orderList) {
			order.setCoupungDTO(coupungService.getProductDetail(order.getCoupungNumber(), order.getOptionNumber(), order.getQuantity()));
		}
		
		return orderList;
	}
	
	public List<OrderDetailsDTO> changeDTOList(List<OrderDetails> orderList) {
		List<OrderDetailsDTO> changedList = new ArrayList<>();
		for (OrderDetails order : orderList) {
			changedList.add(changeDTO(order));
		}
		return changedList;
	}

	public OrderDetailsDTO changeDTO(OrderDetails order) {
		return OrderDetailsDTO.builder()
				.orderDetailNumber(order.getOrderDetailNumber())
				.orderNumber(order.getOrderNumber())
				.coupungNumber(order.getCoupungNumber())
				.optionNumber(order.getOptionNumber())
				.price(order.getPrice())
				.quantity(order.getQuantity())
				.build();
	}
	
	public OrderDetails changeEntity (OrderDetailsDTO order) {
		return OrderDetails.builder()
				.orderDetailNumber(order.getOrderDetailNumber())
				.orderNumber(order.getOrderNumber())
				.coupungNumber(order.getCoupungNumber())
				.optionNumber(order.getOptionNumber())
				.price(order.getPrice())
				.quantity(order.getQuantity())
				.build();
	}

}
