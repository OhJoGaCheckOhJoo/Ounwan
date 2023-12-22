package com.ounwan.dto;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class StoreReportsDTO {
	private Integer storeReportNumber;
	private Integer reviewNumber;
	private Integer danggunNumber;
	private String clientId;
	private Date registeredDate;
	private String reason;
	private Integer category;
}
