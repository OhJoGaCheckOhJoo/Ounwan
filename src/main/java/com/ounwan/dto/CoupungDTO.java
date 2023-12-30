package com.ounwan.dto;

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
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CoupungDTO {
	private Integer coupungNumber;
	private Integer coupungCategoryNumber;
	private String name;
	private Integer price;
	private Integer availableStock;
	private Boolean availableCheck;
	// 이미지 추가
	private List<ProductImagesDTO> image;
	private List<ProductImagesDTO> detailImages;
	private List<CoupungOptionsDTO> options;
	private Integer quantity;
	private Integer salesRate;
	private String category;
}
