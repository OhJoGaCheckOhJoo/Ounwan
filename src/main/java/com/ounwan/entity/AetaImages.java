package com.ounwan.entity;

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
public class AetaImages {

	private Integer aetaNumber;
	private Integer aetaImageNumber;
	private String url;
}
