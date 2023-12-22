package com.ounwan.dto;

import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Builder;
import lombok.Setter;
import lombok.ToString;
import lombok.Getter;

@Builder
@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class CoupungOptionsDTO {
	private Integer coupungOptionNumber;
	private Integer coupungNumber;
	private String name;
}	
