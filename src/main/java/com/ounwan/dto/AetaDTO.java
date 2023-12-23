package com.ounwan.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.EqualsAndHashCode;
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
@EqualsAndHashCode
public class AetaDTO {
	private Integer aetaNumber;
	private String title;
	private String contents;
	private String clientId;
	private Timestamp createdDate;
	private Timestamp updatedDate;
	private Integer views;
	private Integer likes;
}
