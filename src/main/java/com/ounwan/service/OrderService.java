package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.OrdersDTO;
import com.ounwan.entity.Orders;
import com.ounwan.repository.OrderDAO;

@Service
public class OrderService {
	
	@Autowired
	OrderDAO orderDAO;
	
	public List<OrdersDTO> getOrderList(String clientId) {
		return changeDTOList(orderDAO.getOrderList(clientId));
	}
	
	public List<OrdersDTO> changeDTOList(List<Orders> orderList) {
		List<OrdersDTO> changedList = new ArrayList<OrdersDTO>();
		for (Orders order : orderList) {
			changedList.add(changeDTO(order));
		}
		return changedList;
	}
	
	public OrdersDTO changeDTO(Orders order) {
		return OrdersDTO.builder()
				.orderNumber(order.getOrderNumber())
				.clientId(order.getClientId())
				.guestNumber(order.getGuestNumber())
				.tradeHistoryNumber(order.getTradeHistoryNumber())
				.totalPrice(order.getTotalPrice())
				.orderDate(order.getOrderDate())
				.shippingAddress(order.getShippingAddress())
				.receiverName(order.getReceiverName())
				.receiverPhone(order.getReceiverPhone())
				.paymentMethod(order.getPaymentMethod())
				.totalQuantity(order.getTotalQuantity())
				.delieveredDate(order.getDelieveredDate())
				.build();
	}
	
}
