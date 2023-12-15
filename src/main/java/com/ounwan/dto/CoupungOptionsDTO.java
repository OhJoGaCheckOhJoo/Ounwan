package com.ounwan.dto;

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
public class CoupungOptionsDTO {
	private Integer coupungOptionNumber;
	private Integer coupungNumber;
	private String name;
}	
