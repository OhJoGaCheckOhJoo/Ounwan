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
public class Aeta {
	private Integer aetaNumber;
	private String title;
	private String contents;
	private String clientId;
	private Timestamp createdDate;
	private Timestamp updatedDate;
	private Integer views;
	private Integer visibility;
	private String reportReason;
}
