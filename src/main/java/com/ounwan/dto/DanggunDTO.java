package com.ounwan.dto;

import java.sql.Date;

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
public class DanggunDTO {
	private Integer danggunNumber;
	private Integer tradeHistoryNumber;
	private String clientId;
	private String productName;
	private Integer price;
	private String detail;
	private Date uploadDate;
}
