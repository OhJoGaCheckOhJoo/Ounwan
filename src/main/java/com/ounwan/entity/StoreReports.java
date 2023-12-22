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
public class StoreReports {
	private int storeReportNumber;
	private int reviewNumber;
	private int danggunNumber;
	private String clientId;
	private Date registeredDate;
	private String reason;
	private int category;
}
