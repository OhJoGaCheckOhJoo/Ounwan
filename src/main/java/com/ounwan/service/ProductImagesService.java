package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

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
	
	public List<ProductImagesDTO> selectImages(int danggunNumber) {
		List<ProductImages> result = productImagesDAO.selectImages(danggunNumber);
		return (!result.isEmpty()) ? changeDTOlist(result) : null;
	}
	
	public List<ProductImagesDTO> changeDTOlist(List<ProductImages> productImages){
		List<ProductImagesDTO> changeList = new ArrayList<>();
		for(ProductImages p : productImages) {
			changeList.add(changeDTO(p));
		}
		return changeList;
	}
	
	
	public ProductImages changeEntity(ProductImagesDTO productImages) {
		return ProductImages.builder()
							.productImageNumber(productImages.getProductImageNumber())
							.coupungNumber(productImages.getCoupungNumber())
							.danggunNumber(productImages.getDanggunNumber())
							.url(productImages.getUrl())
							.type(productImages.getType())
							.build();
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
