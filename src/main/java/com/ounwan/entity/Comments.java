package com.ounwan.entity;

import java.sql.Date;

import com.ounwan.dto.AetaImagesDTO;

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
	private String client_id;
	private Integer boardNumber;
	private String contents;
	private Date createdDate;
	private Date updatedDate;
	private String likes;

}
