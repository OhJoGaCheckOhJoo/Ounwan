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
public class OunwanGram {
	private Integer communityNumber;
	private String clientId;
	private String contents;
	private Timestamp createdDate;
	private Timestamp updatedDate;
	private Integer likes;
	private String imageUrl;
	private String profileUrl;
	private Integer likesCheck;
}
