package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.entity.ProductImages;
import com.ounwan.repository.ProductImageDAO;

@Service
public class ProductImageService {
	
	@Autowired
	ProductImageDAO productImageDAO;

	public List<ProductImagesDTO> getProductImageByCoupungId(Integer coupungNumber) {
		return changeDTOList(productImageDAO.getProductImageByCoupungId(coupungNumber));
	}
	
	public List<ProductImagesDTO> getDetailImageByCoupungId(Integer coupungNumber) {
		return changeDTOList(productImageDAO.getDetailImageByCoupungId(coupungNumber));
	}
	
	public List<ProductImagesDTO> changeDTOList(List<ProductImages> productImage) {
		List<ProductImagesDTO> changedList = new ArrayList<ProductImagesDTO>();
		for (ProductImages image : productImage) {
			changedList.add(changeDTO(image));
		}
		return changedList;
	}
	
	public ProductImagesDTO changeDTO(ProductImages image) {
		return ProductImagesDTO.builder()
								.productImageNumber(image.getProductImageNumber())
								.coupungNumber(image.getCoupungNumber())
								.danggunNumber(image.getDanggunNumber())
								.type(image.getType())
								.url(image.getUrl())
								.build();
	}
}
