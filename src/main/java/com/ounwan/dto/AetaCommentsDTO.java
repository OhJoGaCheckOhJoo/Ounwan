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
public class AetaCommentsDTO {
	
	private Integer commentNumber;
	private String client_id;
	private Integer boardNumber;
	private String contents;
	private Date createdDate;
	private Date updatedDate;
	private String likes;

}
