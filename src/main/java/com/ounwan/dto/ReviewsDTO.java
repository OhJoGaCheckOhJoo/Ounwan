package com.ounwan.dto;

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
public class ReviewsDTO {
	private Integer reviewNumber;
	private Integer orderDetailNumber;
	private String contents;
	private Double score;
	private Date createdDate;
	private String imageURL;
	private Integer likes;
}
