package com.ounwan.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.dto.TradeHistoryDTO;
import com.ounwan.dto.WishListsDTO;
import com.ounwan.entity.Danggun;
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

	private final static String BUPLOADPATH = "C:/Users/diana/OneDrive/문서/GitHub/Back-end/src/main/webapp/resources";
	private final static String DANGGUNIMAGEPATH = "/images/danggunUploads/";
	
	private final static String UPLOADPATH = "C:/shinhan/sts-workspace/ounwan/src/main/webapp/resources";
	private final static String CURRENTPAGEURL = "http://localhost:9090/myapp/";
	private final static int CURRENTPAGEURLLENGTH = CURRENTPAGEURL.length()-1;


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
		File[] files = new File[count];
		
		images[0] = image;
		imageType[0] = 0;

		if (count > 1) {
			for (int i = 1; i < count; i++) {
				imageType[i] = 1;
				images[i] = detailImages[i - 1];
			}
		}
		
		for (int i = 0; i < count; i++) {
			uploadFileName[i] = clientId + "_" + System.currentTimeMillis() + "_" + i + "."
					+ images[i].getContentType().split("/")[1];
			files[i] = new File(UPLOADPATH + DANGGUNIMAGEPATH + uploadFileName[i]);
		}
		int danggunNumber= danggunDAO.danggunInsert(danggun);

		if (danggunNumber > 0) {
			Map<String, Object> data = new HashMap<>();
			data.put("danggunNumber", danggunNumber);
			for (int i = 0; i < count; i++) {
				images[i].transferTo(files[i]);
				data.put("url", ".." + DANGGUNIMAGEPATH + uploadFileName[i]);
				data.put("type", imageType[i]);
				productImagesDAO.imageInsert(data);
				result += 1;
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
			String tradeStep = tradeHistoryDAO.selectTradeStep(danggunNumber);
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
		String[] uploadFileName = new String[count];
		File[] files = new File[count]; 
		for (int i = 0; i < imagesLength; i++) {
			uploadFileName[i] = clientId + "_" + System.currentTimeMillis() + "_" + i + "." + imageFiles[i].getContentType().split("/")[1];
			files[i] = new File(UPLOADPATH + DANGGUNIMAGEPATH + uploadFileName[i]);
		}
		for(int i = imagesLength; i < count; i++) {
			uploadFileName[i] = clientId + "_" + System.currentTimeMillis() + "_" + i + "." + newDetailImages[i].getContentType().split("/")[1];
			files[i] = new File(UPLOADPATH + DANGGUNIMAGEPATH + uploadFileName[i]);
		}
		if (danggunDAO.updateDanggun(danggun) > 0) {
			Map<String, Object> data = new HashMap<>();
			for (int i = 0; i < imagesLength; i++) {
				imageFiles[i].transferTo(files[i]);
				data.put("url", ".." + DANGGUNIMAGEPATH + uploadFileName[i]);
				data.put("danggunImageNumber", imageFilesNumber[i]);
				new File(UPLOADPATH + oldImageURL[i].substring(CURRENTPAGEURLLENGTH)).delete();
				productImagesDAO.updateDanggunImages(data);
				result += 1;
			}
			Map<String, Object> newData = new HashMap<>();
			newData.put("danggunNumber", danggunNumber);
			for(int i = imagesLength; i < count; i++) {
				newDetailImages[i].transferTo(files[i]);
				newData.put("url", ".." + DANGGUNIMAGEPATH + uploadFileName[i]);
				productImagesDAO.insertNewDetailImages(newData);
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
