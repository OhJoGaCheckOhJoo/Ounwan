package com.ounwan.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class ProductImages {
	private int productImageNumber;
	private int coupungNumber;
	private int danggunNumber;
	private String url;
	private int type;
}
