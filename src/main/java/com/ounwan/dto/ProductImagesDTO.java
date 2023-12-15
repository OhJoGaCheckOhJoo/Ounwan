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
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class ProductImagesDTO {
	private Integer productImageNumber;
	private Integer coupungNumber;
	private Integer danggunNumber;
	private String url;
	private Integer type;
}
