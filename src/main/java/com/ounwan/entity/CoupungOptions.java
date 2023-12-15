package com.ounwan.entity;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Builder;
import lombok.Setter;
import lombok.Getter;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class CoupungOptions {
	private Integer coupungOptionNumber;
	private Integer coupungNumber;
	private String name;
}	
