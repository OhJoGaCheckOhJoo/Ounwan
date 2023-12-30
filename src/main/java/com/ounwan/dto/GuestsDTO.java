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
public class GuestsDTO {
	private Integer guestNumber;
	private String email;
	private String phone;
	// 주문 조회를 위한 컬럼 추가
	private String orderNumber;
}
