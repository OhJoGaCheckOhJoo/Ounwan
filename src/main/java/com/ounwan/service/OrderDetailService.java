package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	
	public List<Map<String, Object>> getAdminOrders(int offset) {
		return orderDetailDAO.getAdminOrders(offset * 20);	
	}
	
	public int getSalesRate(int coupungNumber) {
		return orderDetailDAO.getSalesRate(coupungNumber);
	}

	public List<Integer> getTopFiveCoupungNumber() {
		return orderDetailDAO.getTopFiveCoupungNumber();
	}
	
	public List<Map<String, Object>> getTradeStep() {
		return orderDetailDAO.getTradeStep();
	}
	
	public int countOrders() {
		int ordersNum = orderDetailDAO.countOrders();
		return ordersNum / 20 + (ordersNum % 20 > 0 ? 1 : 0);
	}

	public List<OrderDetailsDTO> getOrderDetails(String orderNumber) {
		List<OrderDetailsDTO> orderList = changeDTOList(orderDetailDAO.getOrderDetails(orderNumber));
		for (OrderDetailsDTO order : orderList) {
			order.setCoupungDTO(coupungService.getProductDetail(order.getCoupungNumber(), order.getCoupungOptionNumber(), order.getQuantity()));
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
	
	public String updateTradeStep(String orderNumber, int tradeStep) {
		Map<String, Object> data = new HashMap<>();
		data.put("orderNumber", orderNumber);
		data.put("tradeStep", tradeStep);
		return orderDetailDAO.updateTradeStep(data) > 0 ? "success" : "fail";
	}

	public OrderDetailsDTO changeDTO(OrderDetails order) {
		return OrderDetailsDTO.builder()
				.orderDetailNumber(order.getOrderDetailNumber())
				.orderNumber(order.getOrderNumber())
				.coupungNumber(order.getCoupungNumber())
				.coupungOptionNumber(order.getCoupungOptionNumber())
				.price(order.getPrice())
				.quantity(order.getQuantity())
				.build();
	}
	
	public OrderDetails changeEntity (OrderDetailsDTO order) {
		return OrderDetails.builder()
				.orderDetailNumber(order.getOrderDetailNumber())
				.orderNumber(order.getOrderNumber())
				.coupungNumber(order.getCoupungNumber())
				.coupungOptionNumber(order.getCoupungOptionNumber())
				.price(order.getPrice())
				.quantity(order.getQuantity())
				.build();
	}

}
