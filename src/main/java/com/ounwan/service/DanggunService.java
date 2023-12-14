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
import com.ounwan.entity.Danggun;
import com.ounwan.repository.DanggunDAO;
import com.ounwan.repository.ProductImagesDAO;

@Service
public class DanggunService {

	@Autowired
	DanggunDAO danggunDAO;

	@Autowired
	ProductImagesDAO imageDAO;

	private final static String UPLOADPATH = "C:/Users/diana/OneDrive/문서/GitHub/Back-end/src/main/webapp/resources";
	private final static String DANGGUNIMAGEPATH = "/images/danggunUploads/";

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

	public boolean danggunInsert(int detailImagesLength, MultipartFile[] detailImages, MultipartFile image,
			String clientId, String productName, int price, String detail) throws IllegalStateException, IOException {
		System.out.println("+++++++++++++++++++++++++++insertService+++++++++++++++++++");
		System.out.println("clientId: " + clientId);
		System.out.println("len: " + detailImagesLength);
		System.out.println("mianImg: " + image);
		System.out.println("^^^^^^^detailImages^^^^^^^");

		int result = 0;
		Danggun danggun = Danggun.builder().clientId(clientId).productName(productName).price(price).detail(detail)
				.build();

		if (detailImages != null) {
			for (MultipartFile file : detailImages) {
				System.out.println(file);
			}
		}

		// 상세 이미지가 없는 경우
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

		// 상세이미지가 있는 경우에만 loop 수행
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

		if (danggunDAO.danggunInsert(danggun) > 0) {
			Map<String, Object> data = new HashMap<>();
			data.put("danggunNumber", danggun.getDanggunNumber());
			for (int i = 0; i < count; i++) {
				images[i].transferTo(files[i]);
				data.put("url", ".." + DANGGUNIMAGEPATH + uploadFileName[i]);
				data.put("type", imageType[i]);
				imageDAO.imageInsert(data);
				result += 1;
			}
		}
		System.out.println(result == count ? "upload succes" : "upload fail");
		return result == count ? true : false;
	}

}
