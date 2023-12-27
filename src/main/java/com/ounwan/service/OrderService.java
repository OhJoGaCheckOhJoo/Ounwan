package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.GuestsDTO;
import com.ounwan.dto.OrderDetailsDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.entity.Orders;
import com.ounwan.repository.OrderDAO;

@Service
public class OrderService {
	
	@Autowired
	OrderDAO orderDAO;
	@Autowired
	OrderDetailService orderDetailService;
	
	public List<OrdersDTO> getOrderList(String clientId) {
		return changeDTOList(orderDAO.getOrderList(clientId));
	}

	public boolean setOrder(OrdersDTO order, ClientsDTO client, GuestsDTO guest) {
		String orderNumber = UUID.randomUUID().toString().split("-")[4]; // 5번째 값 가져오기 (12자리 수)
		order.setOrderNumber(orderNumber);
		order.setTradeHistoryNumber(1);// sql 에서 now 찍기 
		
		List<OrderDetailsDTO> productList = order.getOrderDetails();
		
		int result = 0;
		if (client != null) {
			order.setClientId(client.getClientId());
			result = orderDAO.setOrder(changeEntity(order));
		} else {
			order.setGuestNumber(guest.getGuestNumber());
			result = orderDAO.setOrder(changeEntity(order));
		}
		
		for (OrderDetailsDTO product : productList) {
			orderDetailService.setOrder(product, orderNumber);
		}
		
		return (result > 0) ? true : false;
	}

	public List<OrdersDTO> getAdminOrderList() {
		List<OrdersDTO> orderList = changeDTOList(orderDAO.getAdminOrderList());
		for (OrdersDTO order : orderList) {
			order.setOrderDetails(orderDetailService.getOrderDetails(order.getOrderNumber()));
		}
		return orderList;
	}
	
	public boolean updateTradeStatus(OrdersDTO order) {
		int result = orderDAO.updateTradeStatus(order);
		return result > 0;
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
	
	public Orders changeEntity (OrdersDTO order) {
		return Orders.builder()
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
