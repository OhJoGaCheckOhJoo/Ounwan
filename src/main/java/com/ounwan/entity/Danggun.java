package com.ounwan.entity;

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
public class Danggun {
	private int danggunNumber;
	private int tradeHistoryNumber;
	private String clientId;
	private String name;
	private int price;
	private String detail;
	private Date uploadDate;
}
