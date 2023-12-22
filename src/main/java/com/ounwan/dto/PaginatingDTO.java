package com.ounwan.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@Builder
@ToString
public class PaginatingDTO {
	private int pageNumber; //현재 페이지
	private int maxPageNumber; //전체 페이지 끝번
	private int startPageNumber; //페이지의 시작 번호
	private int endPageNumber; //페이지의 끝 번호
	
}


