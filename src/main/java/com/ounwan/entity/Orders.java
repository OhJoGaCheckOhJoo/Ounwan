package com.ounwan.entity;

import java.sql.Date;

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
public class Orders {
	private String orderNumber;
	private String clientId;
	private Integer guestNumber;
	private int tradeHistoryNumber;
	private int totalPrice;
	private Date orderDate;
	private String shippingAddress;
	private String receiverName;
	private String receiverPhone;
	private String paymentMethod;
	private int totalQuantity;
	private Date delieveredDate;
}
