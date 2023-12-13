package com.ounwan.dto;

import java.sql.Timestamp;
import java.util.List;

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
	private Timestamp createdDate;
	private Timestamp updatedDate;
	private Integer likes;
	private String imageUrl;
	private String profileUrl;
	private Integer likesCheck;
	private List<String> hashTags;
}
