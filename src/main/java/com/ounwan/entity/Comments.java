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
public class Comments {
	private Integer commentNumber;
	private String clientId;
	private Integer aetaNumber;
	private String contents;
	private Timestamp createdDate;
	private Timestamp updatedDate;//빼야댐
	private Integer likes;//빼야댐

}
