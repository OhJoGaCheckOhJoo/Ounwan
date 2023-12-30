package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.CoupungDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.dto.ReviewsDTO;
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
	OrderDetailService orderDetailService; 
	
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
	

	public List<CoupungDTO> getAdminProductList(int offset) {
		List<CoupungDTO> result = new ArrayList<>();
		
		result = changeDTOList(coupungDAO.getAdminProductList(offset));
		
		for (CoupungDTO product : result) {
			product.setSalesRate(orderDetailService.getSalesRate(product.getCoupungNumber()));
			product.setCategory(coupungDAO.getProductCategory(product.getCoupungCategoryNumber()));
			product.setImage(productImageService.getProductImageByCoupungId(product.getCoupungNumber()));
			product.setOptions(coupungOptionsService.selectOptions(product.getCoupungNumber()));
		}
		
		return result;
	}
	
	public int getProductCount() {
		int num = coupungDAO.getProductCount(); 
		return (num / 20) + (num % 20 > 0 ? 1 : 0);
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

	public List<CoupungDTO> getTopFive() {
		List<CoupungDTO> result = new ArrayList<>();
		
		List<Integer> coupungNumbers = orderDetailService.getTopFiveCoupungNumber();
		for (int coupungNumber : coupungNumbers) {
			result.add(getProductDetail(coupungNumber, 0, 0));
		}
		
		return result;
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

	public boolean updateProduct(CoupungDTO product) {
		int result = 0;
		
		result = coupungDAO.updateProduct(changeEntity(product));
		if (product.getImage() != null) 
			result = productImageService.updateProductImage(product.getImage(), product.getCoupungNumber());
		if (product.getOptions() != null)
			result = coupungOptionsService.updateOption(product.getOptions(), product.getCoupungNumber());
		
		return (result > 0);
	}

	public boolean deleteProduct(int coupungNumber) {
		int result = coupungDAO.deleteProduct(coupungNumber);
		return (result > 0);
	}
	
	public boolean checkOrderHistory(String clientId) {
		List<OrdersDTO> orderList = orderService.getOrderList(clientId);
		return (orderList != null) ? true : false;
	}

	public int getPrice(List<String> coupungNumbers, List<String> quantities) {
		int price = 0;
		for (int i = 0; i < coupungNumbers.size(); i++) 
			price += (coupungDAO.getPrice(Integer.parseInt(coupungNumbers.get(i))) * Integer.parseInt(quantities.get(i)));
		return price;
	}
	
	public List<CoupungDTO> getHotDealProductList() {
		List<CoupungDTO> hotDeal = changeDTOList(coupungDAO.getHotDealProductList());
		for (CoupungDTO product : hotDeal) {
			product.setImage(productImageService.getProductImageByCoupungId(product.getCoupungNumber()));
			product.setDetailImages(productImageService.getDetailImageByCoupungId(product.getCoupungNumber()));
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
	
	public List<Map<String, Object>> getReviewList(int coupungNumber) {
		List<Map<String, Object>> reviewList = new ArrayList<Map<String,Object>>();
		
		for(Map<String, Object> data : coupungDAO.getReviewList(coupungNumber)) {
			reviewList.add(data);
		}		
		System.out.println("Service_review: " + reviewList);
		return reviewList;
	}

	public List<Integer> getScoreList(int coupungNumber) {
		Map<String, Object> scoreInfo = new HashMap<>();
		scoreInfo.put("coupungNumber", coupungNumber);
		List<Integer> scoreList = new ArrayList<>(); 
		
		for(int i=1; i<6; i++) {
			scoreInfo.put("score", i);
			scoreList.add(coupungDAO.getScoreList(scoreInfo));
		}
		
		System.out.println("Service_scoreList: " + scoreList);
		
		return scoreList;
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
