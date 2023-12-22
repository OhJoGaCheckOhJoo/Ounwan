package com.ounwan.dto;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
@Builder
public class AetaMultiUploadDTO {

	private String imageName;
	private MultipartFile imageFile;
	private List<AetaMultiUploadDTO> list;
}

