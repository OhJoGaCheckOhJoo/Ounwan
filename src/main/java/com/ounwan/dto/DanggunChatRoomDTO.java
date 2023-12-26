package com.ounwan.dto;

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
public class DanggunChatRoomDTO {
	private String roomId;
	private Integer danggunNumber;
	private String seller;
	private String buyer;
}