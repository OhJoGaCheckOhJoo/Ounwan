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
	ProductImageService productImageService;
	
	@Autowired
	OrderService orderService;
	
	public List<CoupungDTO> getProductList(int categoryId) {
		List<CoupungDTO> result = new ArrayList<>();
		if (categoryId == 0) {
			result = changeDTOList(coupungDAO.getProductList());
			for (CoupungDTO product : result) {
				product.setImage(productImageService.getImageByCoupungId(product.getCoupungNumber()));
			}
			return changeDTOList(coupungDAO.getProductList());
		} else {
			result = changeDTOList(coupungDAO.getProductList());
			for (CoupungDTO product : result) {
				product.setImage(productImageService.getImageByCoupungId(product.getCoupungNumber()));
			}
			return changeDTOList(coupungDAO.getProductListById(categoryId));
		}
	}
	
	public CoupungDTO getProductDetail(String coupungId) {
		CoupungDTO coupung = changeDTO(coupungDAO.getProductDetail(coupungId));
		coupung.setImage(productImageService.getImageByCoupungId(Integer.parseInt(coupungId)));
		return coupung;
	}
	
	public boolean checkOrderHistory(String clientId) {
		List<OrdersDTO> orderList = orderService.getOrderList(clientId);
		return (orderList != null) ? true : false;
	}

	public List<CoupungDTO> getHotDealProductList() {
		List<CoupungDTO> hotDeal = changeDTOList(coupungDAO.getHotDealProductList());
		for (CoupungDTO product : hotDeal) {
			product.setImage(productImageService.getImageByCoupungId(product.getCoupungNumber()));
		}
		return changeDTOList(coupungDAO.getHotDealProductList());
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
				.availableCheck(coupung.isAvailableCheck())
				.build();
	}
}
