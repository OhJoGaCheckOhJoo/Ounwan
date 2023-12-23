package com.ounwan.entity;

import java.sql.Timestamp;

import com.fasterxml.jackson.annotation.JsonFormat;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class SomsomiChat {
	private Integer messageId;
	private String sender;
	private String message;
	@JsonFormat(pattern="yyyy-MM-dd HH:mm:ss",timezone="Asia/Seoul")
	private Timestamp regdate;
}
