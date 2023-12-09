package com.ounwan.dto;

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
public class CoupungDTO {
	private Integer coupungNumber;
	private Integer coupungCategoryNumber;
	private String name;
	private Integer price;
	private Integer availableStock;
	private Boolean availableCheck;
	private String option;
}
