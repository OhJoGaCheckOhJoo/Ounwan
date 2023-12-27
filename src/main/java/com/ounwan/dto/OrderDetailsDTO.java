package com.ounwan.dto;

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
public class OrderDetailsDTO {
	private Integer orderDetailNumber;
	private String orderNumber;
	private Integer optionNumber;
	private Integer coupungNumber;
	private Integer price;
	private Integer quantity;
	// 주문 페이지에 필요한 정보들 추가
	private CoupungDTO coupungDTO;
}
