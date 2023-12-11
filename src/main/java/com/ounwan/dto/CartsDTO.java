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
public class CartsDTO {
	private Integer cartNumber;
	private Integer coupungNumber;
	private String clientId;
	private Integer quantity;
	private CoupungDTO coupung;
}
