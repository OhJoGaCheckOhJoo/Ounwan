package com.ounwan.dto;

import java.sql.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class OrdersDTO {
	private String orderNumber;
	private String clientId;
	private Integer guestNumber;
	private Integer tradeHistoryNumber;
	private Integer totalPrice;
	private Date orderDate;
	private String shippingAddress;
	private String receiverName;
	private String receiverPhone;
	private String paymentMethod;
	private Integer totalQuantity;
	private Date delieveredDate;
	// 주문을 위한 데이터 추가
	private List<OrderDetailsDTO> orderDetails;
}
