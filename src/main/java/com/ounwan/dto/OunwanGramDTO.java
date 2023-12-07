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
public class OunwanGramDTO {
	private Integer communityNumber;
	private String clientId;
	private String contents;
	private Date createdDate;
	private Date updatedDate;
	private Integer likes;
	private String imageUrl;
}
