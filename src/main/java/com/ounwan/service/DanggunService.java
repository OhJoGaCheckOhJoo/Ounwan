package com.ounwan.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.entity.Danggun;
import com.ounwan.entity.ProductImages;
import com.ounwan.entity.WishLists;
import com.ounwan.repository.DanggunDAO;
import com.ounwan.repository.ProductImagesDAO;
import com.ounwan.repository.TradeHistoryDAO;
import com.ounwan.repository.WishListsDAO;

@Service
public class DanggunService {

	@Autowired
	DanggunDAO danggunDAO;
	
	@Autowired
	ProductImagesService productImageService;

	@Autowired
	ProductImagesDAO productImagesDAO;
	
	@Autowired
	TradeHistoryDAO tradeHistoryDAO;
	
	@Autowired
	WishListsService wishListsService;
	
	@Autowired
	WishListsDAO wishListsDAO;
	
	@Autowired
	AmazonS3 amazonS3;
	
	private static final String BUCKET = "ounwan";

	public List<DanggunDTO> searchProduct(String name) {
		List<DanggunDTO> searchList = new ArrayList<DanggunDTO>();
		if (name.length() > 0) {
			for (Danggun danggun : danggunDAO.searchProduct(name)) {
				searchList.add(changeDTO(danggun));
			}
		}
		return searchList;
	}

	public List<DanggunDTO> listAll() {
		List<DanggunDTO> list = new ArrayList<>();
		for (Danggun danggun : danggunDAO.listAll()) {
			list.add(changeDTO(danggun));
		}
		return list;
	}
	
	public int danggunInsert(int detailImagesLength, MultipartFile[] detailImages, MultipartFile image,
			String clientId, String productName, int price, String detail) throws IllegalStateException, IOException {
		
		int result = 0;
		Danggun danggun = Danggun.builder().clientId(clientId).productName(productName).price(price).detail(detail)
				.build();
		
		if (detailImages == null) {
			detailImagesLength = 0;
		}
		
		int count = detailImagesLength + 1;
		String[] uploadFileName = new String[count];
		int[] imageType = new int[count];
		MultipartFile[] images = new MultipartFile[count];
		
		images[0] = image;
		imageType[0] = 0;

		if (count > 1) {
			for (int i = 1; i < count; i++) {
				imageType[i] = 1;
				images[i] = detailImages[i - 1];
			}
		}
		
		for (int i = 0; i < count; i++) {
			String newFileName = System.currentTimeMillis() + "." + images[i].getContentType().split("/")[1];
			
			ObjectMetadata metadata = new ObjectMetadata();
			metadata.setContentLength(images[i].getSize());
			metadata.setContentType(images[i].getContentType());
			
			amazonS3.putObject(BUCKET, newFileName, images[i].getInputStream(), metadata);
			
			uploadFileName[i] = amazonS3.getUrl(BUCKET, newFileName).toString();
		}
		int danggunNumber= danggunDAO.danggunInsert(danggun);

		if (danggunNumber > 0) {
			for (int i = 0; i < count; i++) {
				result += productImagesDAO.imageInsert(ProductImages.builder()
															.danggunNumber(danggunNumber)
															.url(uploadFileName[i])
															.type(imageType[i])
															.build());
			}
		}
		return result== count ? 1 : 0;
	}

	public DanggunDTO selectDanggun(String clientId, int danggunNumber) {
		Danggun resultDanggun = danggunDAO.selectDanggun(danggunNumber);
//		여기서 danggun 결과, tradeHistoryNumber로 거래 결과 나오고, danggunNumber로 이미지랑 찜 리스트 가져오기 
		DanggunDTO danggun = null;
		if(resultDanggun != null) {
			danggun = changeDTO(resultDanggun);
			int tradeHistoryNumber = danggun.getTradeHistoryNumber();
			String tradeStep = tradeHistoryDAO.selectTradeStep(tradeHistoryNumber);
			danggun.setTradeStep(tradeStep);
		}
		
		List<ProductImagesDTO> resultImages = productImageService.selectImages(danggunNumber);
		if (resultImages != null) {
			danggun.setProductImagesList(resultImages);
		}
		
		int zzimCount = wishListsService.selectCountZzim(danggunNumber);
		danggun.setCountZzim(zzimCount);
		
		List<Integer> zzimList = wishListsDAO.hasZzim(clientId);
		if(zzimList.contains(danggunNumber)) {
			danggun.setWishListImg(1);
		}else {
			danggun.setWishListImg(0);
		}
		
		return danggun;
	}

	public Map<String, Integer> danggunWishList(String clientId, int danggunNumber) {
		Map<String, Integer> result = new HashMap<>();
		List<Integer> zzimList = wishListsDAO.hasZzim(clientId);
		WishLists wishLists = new WishLists();
		wishLists.setClientId(clientId);
		wishLists.setDanggunNumber(danggunNumber);

		if(zzimList.contains(danggunNumber)) {
			if(wishListsDAO.minusZzim(wishLists) > 0) {
				result.put("likesCheck", 0);
			}else {
				result.put("likesCheck", 2);
			}
		}else {
			if(wishListsDAO.plusZzim(wishLists) > 0) {
				result.put("likesCheck", 1);
			}else {
				result.put("likesCheck", 2);
			}
		}
		
		int zzimCount = wishListsService.selectCountZzim(danggunNumber);
		result.put("zzimCount", zzimCount);
		
		result.put("danggunNumber",danggunNumber);
		
		return result;
	}
	
	public boolean deleteDanggun(DanggunDTO danggun) {
		int result = danggunDAO.deleteDanggun(changeEntity(danggun));
		return (result > 0) ? true : false;
	} 

	public boolean updateDanggun(MultipartFile[] imageFiles, int[] imageFilesNumber, String[] oldImageURL, MultipartFile[] newDetailImages,
			String loginclientId, int danggunNumber, String clientId, String productName, int price, String detail,
			int tradeHistoryNumber, int imagesLength, int newImagesLength) throws IllegalStateException, IOException {
		Danggun danggun = danggunDAO.selectDanggun(danggunNumber);
		danggun.setClientId(loginclientId);
		danggun.setProductName(productName);
		danggun.setPrice(price);
		danggun.setDetail(detail);
		danggun.setTradeHistoryNumber(tradeHistoryNumber);
		int result = 0;
		int count = imagesLength + newImagesLength;
		System.out.println("count : " + count);
		String[] uploadFileName = new String[count];
		
		for (int i = 0; i < imagesLength; i++) {
			uploadFileName[i] = clientId + "_" + System.currentTimeMillis() + "_" + i + "." + imageFiles[i].getContentType().split("/")[1];
		}
		for(int i = imagesLength; i < count; i++) {
			uploadFileName[i] = clientId + "_" + System.currentTimeMillis() + "_" + i + "." + newDetailImages[i - imagesLength].getContentType().split("/")[1];
		}
		
		if (danggunDAO.updateDanggun(danggun) > 0) {
			for (int i = 0; i < imagesLength; i++) {
				ObjectMetadata metadata = new ObjectMetadata();
				metadata.setContentLength(imageFiles[i].getSize());
				metadata.setContentType(imageFiles[i].getContentType());
				
				amazonS3.putObject(BUCKET, uploadFileName[i], imageFiles[i].getInputStream(), metadata);
				uploadFileName[i] = amazonS3.getUrl(BUCKET, uploadFileName[i]).toString();
				System.out.println("update : " + uploadFileName[i]);
				
				amazonS3.deleteObject(BUCKET, oldImageURL[i]);
				productImagesDAO.updateDanggunImages(ProductImages.builder()
																	.productImageNumber(imageFilesNumber[i])
																	.url(uploadFileName[i])
																	.build());
				result += 1;
			}
			for(int i = imagesLength; i < count; i++) {
				ObjectMetadata metadata = new ObjectMetadata();
				metadata.setContentLength(newDetailImages[i - imagesLength].getSize());
				metadata.setContentType(newDetailImages[i - imagesLength].getContentType());
				
				amazonS3.putObject(BUCKET, uploadFileName[i], newDetailImages[i - imagesLength].getInputStream(), metadata);
				
				String url = amazonS3.getUrl(BUCKET, uploadFileName[i]).toString();
				System.out.println("new : " + url);
				productImagesDAO.insertNewDetailImages(ProductImages.builder()
																	.danggunNumber(danggunNumber)
																	.url(url)
																	.build());
				result += 1;
			}
		}

	return(result==count)?true:false;

	}

	public Danggun changeEntity(DanggunDTO danggun) {
		return Danggun.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}

	public DanggunDTO changeDTO(Danggun danggun) {
		return DanggunDTO.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}

}
