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
public class Coupung {
	private int coupungNumber;
	private int coupungCategoryNumber;
	private String name;
	private int price;
	private int availableStock;
	private boolean availableCheck;
	private String option;
}
