package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.entity.ProductImages;
import com.ounwan.repository.ProductImageDAO;

@Service
public class ProductImageService {
	
	@Autowired
	ProductImageDAO productImageDAO;

	public ProductImagesDTO getImageByCoupungId(Integer coupungNumber) {
		return changeDto(productImageDAO.getImageByCoupungId(coupungNumber));
	}
	
	public ProductImagesDTO changeDto(ProductImages image) {
		return ProductImagesDTO.builder()
								.productImageNumber(image.getProductImageNumber())
								.coupungNumber(image.getCoupungNumber())
								.danggunNumber(image.getDanggunNumber())
								.type(image.getType())
								.url(image.getUrl())
								.build();
	}

}
