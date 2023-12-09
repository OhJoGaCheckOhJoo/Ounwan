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
public class AetaBoards {
	private Integer boardNumber;
	private String title;
	private String contents;
	private String clientId;
	private Date createdDate;
	private Date updatedDate;
	private Integer views;
	private Integer likes;
}
