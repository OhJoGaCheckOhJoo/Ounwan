package com.ounwan.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
public class AetaLikes {

	private Integer likeNumber;
	private Integer aetaNumber;
	private String clientId;
	// front를 위한 값 추가
	private Boolean like;
	private Boolean dislike;
	private Integer likesCount;

}
