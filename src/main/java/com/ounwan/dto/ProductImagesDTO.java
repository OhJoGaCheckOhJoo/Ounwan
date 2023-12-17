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
public class ProductImagesDTO {
	private Integer productImageNumber;
	private Integer coupungNumber;
	private Integer danggunNumber;
	private String url;
	private Integer type;
}