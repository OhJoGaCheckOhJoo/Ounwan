package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.entity.ProductImages;
import com.ounwan.repository.ProductImagesDAO;

@Service
public class ProductImagesService {

	@Autowired
	ProductImagesDAO productImagesDAO;
	
	public ProductImagesDTO selectAllImages(Integer danggunNumber) {
		ProductImagesDTO image = changeDTO(productImagesDAO.selectAllImages(danggunNumber));
		return image;
	}
	
	public ProductImagesDTO changeDTO(ProductImages productImages) {
		return ProductImagesDTO.builder()
							.productImageNumber(productImages.getProductImageNumber())
							.coupungNumber(productImages.getCoupungNumber())
							.danggunNumber(productImages.getDanggunNumber())
							.url(productImages.getUrl())
							.type(productImages.getType())
							.build();
	}	
}
