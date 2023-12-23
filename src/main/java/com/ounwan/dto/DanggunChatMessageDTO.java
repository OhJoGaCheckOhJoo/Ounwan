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
public class DanggunChatMessageDTO {
	private Integer messageId;
	private String roomId;
	private String sender;
	private String message;
	private Date regdate;
}

