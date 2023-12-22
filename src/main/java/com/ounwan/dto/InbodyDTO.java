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
public class InbodyDTO {
	private Integer inbodyNumber;
	private String clientId;
	private Double height;
	private Double weight;
	private Double skeletalMusclesMass;
	private Double bodyWater;
	private Double bmr;
	private Double bmi;
	private Integer inbodyScore;
	private Date updatedDate;
}

