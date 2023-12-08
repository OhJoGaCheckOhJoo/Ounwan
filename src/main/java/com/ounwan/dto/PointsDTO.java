package com.ounwan.dto;

import java.sql.Date;

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
public class PointsDTO {
	private Integer pointNumber;
	private String clientId;
	private String orderNumber;
	private Integer earnPoint;
	private Integer usedPoint;
	private Date createdDate;
	private String detail;
}
