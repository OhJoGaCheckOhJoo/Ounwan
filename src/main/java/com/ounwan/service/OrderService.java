package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.CartsDTO;
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
	@Autowired
	CoupungService coupungService;
	@Autowired
	CartService cartService;
	
	public List<OrdersDTO> getOrderList(String clientId) {
		return changeDTOList(orderDAO.getOrderList(clientId));
	}

	public boolean setOrder(OrdersDTO orderDTO, ClientsDTO client, GuestsDTO guest, HttpSession session) {
		List<OrderDetailsDTO> orderDetails = orderDTO.getOrderDetails();
		
		for (OrderDetailsDTO product : orderDetails) {
			int availableStock = coupungService.getAvaliableStock(product.getCoupungNumber());
			if (availableStock < product.getQuantity())
				return false;
			product.setAvailableStock(availableStock - product.getQuantity());
			product.setPrice(coupungService.getPrice(product.getCoupungNumber(), product.getQuantity()));
		}
		
		Orders order = putOrderInfo(orderDTO, client, guest);
		
		int result = orderDAO.setOrder(order);
		String orderNumber = order.getOrderNumber();
		
		for (OrderDetailsDTO product : orderDetails) {
			orderDetailService.setOrder(product, orderNumber);
			coupungService.updateAvailableStock(product.getCoupungNumber(), product.getAvailableStock());
		}
		
		deleteCart(orderDetails, session, client, guest);
		
		return (result > 0) ? true : false;
	}
	
	public void deleteCart(List<OrderDetailsDTO> orderDetails, HttpSession session, ClientsDTO client, GuestsDTO guest) {
		List<CartsDTO> guestCarts = (List<CartsDTO>) session.getAttribute("cartList");
		
		for (OrderDetailsDTO orderDetail : orderDetails) {
			if (guest != null) {// 비회원 주문된거 삭제 해주기
				if (guestCarts != null) {
					for(int i = 0; i < guestCarts.size(); i++) {
						if(orderDetail.getCoupungNumber() == guestCarts.get(i).getCoupungNumber() 
								&& orderDetail.getCoupungOptionNumber() == guestCarts.get(i).getCoupungOptionNumber())
							guestCarts.remove(i);
					}
					session.setAttribute("cartList", guestCarts);
				}
			} else {
				List<Map<Object, Object>> clientCarts = cartService.getCartById(client.getClientId());
				if (clientCarts != null) {
					for (Map<Object, Object> cart : clientCarts) {
						if (orderDetail.getCoupungNumber() == cart.get("coupungNumber") 
								&& orderDetail.getCoupungOptionNumber() == cart.get("optionNumber"))
							cartService.deleteCart(CartsDTO.builder()
															.clientId(client.getClientId())
															.coupungNumber(orderDetail.getCoupungNumber())
															.coupungOptionNumber(orderDetail.getCoupungOptionNumber())
															.build());
					}
				}
			}
		}
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

	public String getOrderNumber(ClientsDTO client, GuestsDTO guest) {
		if (client != null) {
			return orderDAO.getClientLatestOrderNumber(client.getClientId());
		}
		return orderDAO.getGuestLatestOrderNumber(guest.getGuestNumber());
	}
	
	public Orders putOrderInfo(OrdersDTO orderDTO, ClientsDTO client, GuestsDTO guest) {
		String orderNumber = UUID.randomUUID().toString().split("-")[4]; // 5번째 값 가져오기 (12자리 수)
		orderDTO.setTradeHistoryNumber(1);
		return Orders.builder()
					.orderNumber(orderNumber)
					.clientId((client != null)? client.getClientId() : null)
					.guestNumber((guest != null) ? guest.getGuestNumber() : null)
					.tradeHistoryNumber(1)
					.totalPrice(orderDTO.getTotalPrice())
					.shippingAddress(orderDTO.getShippingAddress())
					.receiverName(orderDTO.getReceiverName())
					.receiverPhone(orderDTO.getReceiverPhone())
					.paymentMethod(orderDTO.getPaymentMethod())
					.totalQuantity(orderDTO.getTotalQuantity())
					.build();
	}

	public OrdersDTO getOrders(String orderNumber) {
		OrdersDTO order = changeDTO(orderDAO.getOrderById(orderNumber));
		order.setOrderDetails(orderDetailService.getOrderDetails(orderNumber));
		System.out.println("HERE : " + order);
		return order;
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
