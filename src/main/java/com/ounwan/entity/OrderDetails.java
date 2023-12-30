package com.ounwan.entity;

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
public class OrderDetails {
	private Integer orderDetailNumber;
	private String orderNumber;
	private Integer coupungNumber;
	private Integer coupungOptionNumber;
	private Integer price;
	private Integer quantity;
}
