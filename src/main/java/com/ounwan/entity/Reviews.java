package com.ounwan.entity;

import lombok.AllArgsConstructor;

import java.sql.Date;

import lombok.Builder;
import lombok.NoArgsConstructor;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class Reviews {
	private int reviewNumber;
	private int orderDetailNumber;
	private String contents;
	private double score;
	private Date createdDate;
	private String imageURL;
	private int likes;
}
