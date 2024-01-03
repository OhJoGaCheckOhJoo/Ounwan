package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	OrderDetailService orderDetailService; 
	
	@Autowired
	OrderService orderService;
	
	public List<Map<String, Object>> getAllCategories() {
		return coupungDAO.getAllCategories();
	}

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
	
	public List<CoupungDTO> getAdminProductList(int offset, String searchOption, String searchValue, String sortOption) {
		List<CoupungDTO> result = new ArrayList<>();
		Map<String, Object> data = new HashMap<>();
		data.put("offset", offset);
		data.put("searchOption", searchOption);
		data.put("searchValue", searchValue);
		data.put("sortOption", sortOption);
		result = changeDTOList(coupungDAO.getAdminProductList(data));
		
		for (CoupungDTO product : result) {
			product.setSalesRate(orderDetailService.getSalesRate(product.getCoupungNumber()));
			product.setCategory(coupungDAO.getProductCategory(product.getCoupungCategoryNumber()));
			product.setImage(productImageService.getProductImageByCoupungId(product.getCoupungNumber()));
			product.setOptions(coupungOptionsService.selectOptions(product.getCoupungNumber()));
		}
		
		return result;
	}
	
	public int getProductCount(String searchOption, String searchValue) {
		Map<String, Object> data = new HashMap<>();
		data.put("searchOption", searchOption);
		data.put("searchValue", searchValue);
		int num = coupungDAO.getProductCount(data); 
		return (num / 20) + (num % 20 > 0 ? 1 : 0);
	}
	
	public String startSales(String[] productList) {
		int result = 1;
		for(String coupungNumber : productList) {
			Coupung product = coupungDAO.getProductDetail(Integer.parseInt(coupungNumber));
			product.setAvailableCheck(true);
			result *= coupungDAO.updateProductSales(product);
		}
		if(result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	public String stopSales(String[] productList) {
		int result = 1;
		for(String coupungNumber : productList) {
			Coupung product = coupungDAO.getProductDetail(Integer.parseInt(coupungNumber));
			product.setAvailableCheck(false);
			result *= coupungDAO.updateProductSales(product);
		}
		if(result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}

	public boolean updateProduct(CoupungDTO product, String[] addOptions, String[] deleteOptions, String[] image, String[] deleteImage, String[] detailImages, String[] deleteDetailImg) {
		int result = coupungDAO.updateProduct(changeEntity(product));
		result *= productImageService.insertProductImg(product.getCoupungNumber(), image);
		if(addOptions != null) {
			result *= coupungOptionsService.insertOption(product.getCoupungNumber(), addOptions);
		}
		if(deleteOptions != null) {
			result *= coupungOptionsService.deleteOption(deleteOptions);
		}
		if(detailImages != null) {
			result *= productImageService.insertDetailImg(product.getCoupungNumber(), detailImages);
		}
		if(deleteImage != null) {
			result *= productImageService.deleteProductImg(deleteImage);
		}
		if(deleteDetailImg != null) {
			result *= productImageService.deleteProductImg(deleteDetailImg);
		}
		return (result > 0);
	}
	
	public boolean insertProduct(CoupungDTO product, String[] options, String[] images, String[] detailImages) {
		Coupung coupung = changeEntity(product);
		int result = coupungDAO.insertProduct(coupung);
		if (result > 0) {
			int coupungNumber = coupung.getCoupungNumber();
			result *= coupungOptionsService.insertOption(coupungNumber, options);
			result *= productImageService.insertProductImg(coupungNumber, images);
			if(detailImages != null) {
				result *= productImageService.insertDetailImg(coupungNumber, detailImages);
			}
		}
		return result > 0;
	}
	
	public CoupungDTO getAdminProductDetail(int coupungNumber) {
		CoupungDTO product = changeDTO(coupungDAO.getProductDetail(coupungNumber));
		product.setImage(productImageService.getProductImageByCoupungId(product.getCoupungNumber()));
		product.setDetailImages(productImageService.getDetailImageByCoupungId(product.getCoupungNumber()));
		product.setOptions(coupungOptionsService.selectOptions(coupungNumber));
		product.setCategory(coupungDAO.getProductCategory(coupungNumber));
		return product;
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
	
	public int getPrice (int coupungNumber, int quantities) {
		return (coupungDAO.getPrice(coupungNumber) * quantities);
	}

	public int getAvaliableStock(int coupungNumber) {
		return coupungDAO.getAvailableStock(coupungNumber);
	}
	
	public void updateAvailableStock(int coupungNumber, int availableStock) {
		if (availableStock < 10) {
			coupungDAO.updateAvailableStock(Coupung.builder()
						.coupungNumber(coupungNumber)
						.availableStock(availableStock)
						.availableCheck(false)
						.build());
		} else {
		coupungDAO.updateAvailableStock(Coupung.builder()
												.coupungNumber(coupungNumber)
												.availableStock(availableStock)
												.availableCheck(true)
												.build());
		}
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
