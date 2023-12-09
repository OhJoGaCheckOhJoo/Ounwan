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
public class AetaDTO {
	private Integer boardNumber;
	private String title;
	private String contents;
	private String clientId;
	private Date createdDate;
	private Date updatedDate;
	private Integer views;
	private Integer likes;
}
