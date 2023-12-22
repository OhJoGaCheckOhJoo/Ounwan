package com.ounwan.entity;

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
public class Points {
	private int pointNumber;
	private String clientId;
	private String orderNumber;
	private int earnPoint;
	private int usedPoint;
	private Date createdDate;
	private String detail;
}
