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
public class Carts {
	private Integer cartNumber;
	private Integer coupungNumber;
	private String clientId;
	private Integer quantity;
	private Coupung coupung;
}
