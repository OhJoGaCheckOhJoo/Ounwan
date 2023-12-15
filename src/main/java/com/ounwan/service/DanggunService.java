package com.ounwan.service;

import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.entity.Danggun;
import com.ounwan.repository.DanggunDAO;
import com.ounwan.repository.ProductImagesDAO;

@Service
public class DanggunService {

	@Autowired
	DanggunDAO danggunDAO;

	@Autowired
	ProductImagesDAO productImagesDAO;

	private final static String UPLOADPATH = "C:/shinhan/sts-workspace/ounwan/src/main/webapp/resources";
	private final static String CURRENTPAGEURL = "http://localhost:9090/myapp/";
	private final static int CURRENTPAGEURLLENGTH = CURRENTPAGEURL.length()-1;
	private final static String DANGGUNIMAGEPATH = "/images/danggunUploads/";

	public DanggunDTO selectDanggun(int danggunNumber) {
		Danggun result = danggunDAO.selectDanggun(danggunNumber);
		return (result != null) ? changeDTO(result) : null;
	}

	public boolean deleteDanggun(DanggunDTO danggun) {
		int result = danggunDAO.deleteDanggun(changeEntity(danggun));
		return (result > 0) ? true : false;
	}

	public boolean updateDanggun(MultipartFile[] imageFiles, int[] imageFilesNumber, String[] oldImageURL, MultipartFile[] newDetailImages,
			String loginclientId, int danggunNumber, String clientId, String name, int price, String detail,
			int tradeHistoryNumber, int imagesLength, int newImagesLength) throws IllegalStateException, IOException {
		Danggun danggun = danggunDAO.selectDanggun(danggunNumber);
		danggun.setClientId(loginclientId);
		danggun.setName(name);
		danggun.setPrice(price);
		danggun.setDetail(detail);
		danggun.setTradeHistoryNumber(tradeHistoryNumber);
		int result = 0;
		int count = imagesLength + newImagesLength;
		String[] uploadFileName = new String[count];
		File[] files = new File[count]; // martipartfile에서 파일 경로만 입력
		for (int i = 0; i < imagesLength; i++) {
			uploadFileName[i] = clientId + "_" + System.currentTimeMillis() + "_" + i + "." + imageFiles[i].getContentType().split("/")[1];
			files[i] = new File(UPLOADPATH + DANGGUNIMAGEPATH + uploadFileName[i]);
		}
		for(int j = imagesLength; j < count; j++) {
			uploadFileName[j] = clientId + "_" + System.currentTimeMillis() + "_" + j + "." + newDetailImages[j].getContentType().split("/")[1];
			files[j] = new File(UPLOADPATH + DANGGUNIMAGEPATH + uploadFileName[j]);
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
				.name(danggun.getName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}

	public DanggunDTO changeDTO(Danggun danggun) {
		return DanggunDTO.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.name(danggun.getName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}

}
