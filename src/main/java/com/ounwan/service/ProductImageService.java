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
	
	public int insertProductImg(Integer coupungNumber, String[] images) {
		int result = 1;
		for(int i = 0; i < images.length; i++) {
			if(!images[i].equals(".")) {
				result *= productImageDAO.insertImage(ProductImages.builder().coupungNumber(coupungNumber).url(images[i]).type(i > 0 ? 1 : 0).build());
			}	
		}
		return result;
	}

	public int insertDetailImg(Integer coupungNumber, String[] detailImages) {
		int result = 1;
		for(String url : detailImages) {
			if(!url.equals(".")) {
				result *= productImageDAO.insertImage(ProductImages.builder().coupungNumber(coupungNumber).url(url).type(2).build());
			}
		}
		return result;
	}

	public int deleteProductImg(String[] images) {
		int result = 1;
		for(String productImageNumber : images) {
			result *= productImageDAO.deleteImage(Integer.parseInt(productImageNumber));
		}
		return result;
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
	
	public ProductImages changeEntity(ProductImagesDTO image) {
		return ProductImages.builder()
							.productImageNumber(image.getProductImageNumber())
							.coupungNumber(image.getCoupungNumber())
							.danggunNumber(image.getDanggunNumber())
							.type(image.getType())
							.url(image.getUrl())
							.build();
	}

}
