package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.CoupungDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.entity.Coupung;
import com.ounwan.repository.CoupungDAO;

@Service
public class CoupungService {
	
	@Autowired
	CoupungDAO coupungDAO;
	
	@Autowired
	CoupungOptionsService coupungOptionsService;
	
	@Autowired
	ProductImageService productImageService;
	
	@Autowired
	OrderService orderService;

	public List<CoupungDTO> getProductList(int categoryId) {
		List<CoupungDTO> result = new ArrayList<>();
		if (categoryId == 0) {
			result = changeDTOList(coupungDAO.getProductList());
			for (CoupungDTO product : result) {
				product.setImage(productImageService.getProductImageByCoupungId(product.getCoupungNumber()));
				product.setDetailImages(productImageService.getDetailImageByCoupungId(product.getCoupungNumber()));
			}
			return result;
		} else {
			result = changeDTOList(coupungDAO.getProductListById(categoryId));
			for (CoupungDTO product : result) {
				product.setImage(productImageService.getProductImageByCoupungId(product.getCoupungNumber()));
				product.setDetailImages(productImageService.getDetailImageByCoupungId(product.getCoupungNumber()));
			}
			return result;
		}
	}
	

	public List<CoupungDTO> findByProductName(String text) {
		List<CoupungDTO> result = changeDTOList(coupungDAO.findByName(text));
		for (CoupungDTO product : result) {
			product.setImage(productImageService.getProductImageByCoupungId(product.getCoupungNumber()));
			product.setDetailImages(productImageService.getDetailImageByCoupungId(product.getCoupungNumber()));
		}
		return result;
	}
	
	public CoupungDTO getProductDetail(int coupungNumber, int optionNumber, int quantity) {
		CoupungDTO coupung = changeDTO(coupungDAO.getProductDetail(coupungNumber));
		coupung.setImage(productImageService.getProductImageByCoupungId(coupungNumber));
		coupung.setDetailImages(productImageService.getDetailImageByCoupungId(coupungNumber));
		if(optionNumber == 0 && quantity == 0) {
			coupung.setOptions(coupungOptionsService.selectOptions(coupungNumber));
		} else {
			coupung.setOptions(coupungOptionsService.getOptionByOptionId(optionNumber));
			coupung.setQuantity(quantity);
		}
		return coupung;
	}
	
	public boolean checkOrderHistory(String clientId) {
		List<OrdersDTO> orderList = orderService.getOrderList(clientId);
		return (orderList != null) ? true : false;
	}

	public List<CoupungDTO> getHotDealProductList() {
		List<CoupungDTO> hotDeal = changeDTOList(coupungDAO.getHotDealProductList());
		for (CoupungDTO product : hotDeal) {
			product.setImage(productImageService.getProductImageByCoupungId(product.getCoupungNumber()));
			product.setDetailImages(productImageService.getDetailImageByCoupungId(product.getCoupungNumber()));
		}
		return changeDTOList(coupungDAO.getHotDealProductList());
	}

	public int insertProduct(CoupungDTO product) {
		Coupung coupung = changeEntity(product);
		int result = coupungDAO.insertProduct(coupung);
		if (result > 0) {
			int coupungNumber = coupung.getCoupungNumber();
			result = coupungOptionsService.insertOption(product.getOptions(), coupungNumber);
			result = productImageService.insertImage(product.getImage(), coupungNumber);
		}
		return result;
	}
	
	public List<CoupungDTO> changeDTOList(List<Coupung> productList) {
		List<CoupungDTO> changedList = new ArrayList<CoupungDTO>();
		for (Coupung coupung : productList) {
			changedList.add(changeDTO(coupung));
		}
		return changedList;
	}
	
	public CoupungDTO changeDTO(Coupung coupung) {
		return CoupungDTO.builder()
				.coupungNumber(coupung.getCoupungNumber())
				.coupungCategoryNumber(coupung.getCoupungCategoryNumber())
				.name(coupung.getName())
				.price(coupung.getPrice())
				.availableStock(coupung.getAvailableStock())
				.availableCheck(coupung.getAvailableCheck())
				.build();
	}
	
	public Coupung changeEntity(CoupungDTO coupungDTO) {
		return Coupung.builder()
						.coupungNumber(coupungDTO.getCoupungNumber())
						.coupungCategoryNumber(coupungDTO.getCoupungCategoryNumber())
						.name(coupungDTO.getName())
						.price(coupungDTO.getPrice())
						.availableStock(coupungDTO.getAvailableStock())
						.availableCheck(coupungDTO.getAvailableCheck())
						.build();
	}
}
