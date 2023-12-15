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
public class DanggunDTO {
	private Integer danggunNumber;
	private Integer tradeHistoryNumber;
	private String clientId;
	private String name;
	private Integer price;
	private String detail;
	private Date uploadDate;
	//danggun picture url 추가
	private String url;
	private ProductImagesDTO productImagesDTO;
}
