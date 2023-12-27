package com.ounwan.entity;

import java.sql.Timestamp;

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
public class Reviews {
	private Integer reviewNumber;
	private Integer orderDetailNumber;
	private String contents;
	private Double score;
	private Timestamp createdDate;
	private String ImageUrl;
}
