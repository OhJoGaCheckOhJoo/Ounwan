package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.DanggunDTO;
import com.ounwan.entity.Aeta;
import com.ounwan.entity.Danggun;


import java.io.File;
import java.io.IOException;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.entity.Clients;
import com.ounwan.repository.ClientsDAO;
import com.ounwan.repository.MyPageDAO;

@Service
public class MyPageService {

	@Autowired
	MyPageDAO myPageDAO;

	@Autowired
	ClientsDAO clientsDAO;

		
//	private final static String UPLOADPATH = "D:\\github_desktop\\Back-end\\src\\main\\webapp\\resources";
	private final static String UPLOADPATH = "C:/Users/diana/OneDrive/문서/GitHub/Back-end/src/main/webapp/resources";
	private final static String IMAGEPATH = "/images/uploads/";
	
	public int getWishListCount(String userId) {
		return myPageDAO.getWishListCount(userId);
	}

	public int getCartListCount(String userId) {
		return myPageDAO.getCartListCount(userId);
	}
	
	public List<Map<String, Object>> orderListPreview(String userId) {
		return myPageDAO.getOrderPreviewList(userId);
	}

	public List<AetaDTO> aetaListPreview(String userId) {
		return changeDTOList(myPageDAO.getAetaPreviewList(userId));
	}

	public List<Map<String, Object>> cartListPreview(String userId) {
		return myPageDAO.getCartPreviewList(userId);
		
	}
	
	public List<Map<String, Object>> getCoupungOrderList(String userId) {
		// TODO Auto-generated method stub
		return myPageDAO.getCoupungOrderList(userId);
	}

	public List<Map<String, Object>> getDanggunSaleList(String userId) {
		return myPageDAO.getDanggunSaleList(userId);
	}
	
	public List<Map<String, Object>> getDanggunWishList(String userId) {
		return myPageDAO.getDanggunWishList(userId);
		
	}
	
	public boolean deleteWishList(List<String> selectWishLists) {
		int result = 0;
		
		for(String wishList: selectWishLists) {
			myPageDAO.deleteWishList(Integer.parseInt(wishList));
			result++;
		}
		return selectWishLists.size()==result? true: false;
	}
	
	public List<AetaDTO> getAetaList(String userId) {		
		return  changeDTOList(myPageDAO.getAetaList(userId));
	}
	
	public List<Map<String, Object>> getReviewList(String userId) {
		return myPageDAO.getReviewList(userId);
	}
	
	public boolean deleteReviewList(List<String> selectedReviews) {
		int result =0;
		for(String reviewNumber: selectedReviews) {
			myPageDAO.deleteReviewList(Integer.parseInt(reviewNumber));
			result++;
		}
		
		return selectedReviews.size()==result? true: false;
		
	}
	
	public DanggunDTO changeDTO(Danggun danggun) {
		return DanggunDTO.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}
	
	public List<AetaDTO> changeDTOList(List<Aeta> aeta){
        List<AetaDTO> changeList = new ArrayList<>();
        for(Aeta data : aeta) {
            changeList.add(changeDTO(data));
        }
        return changeList;
    }

	public AetaDTO changeDTO(Aeta aeta) {
		return AetaDTO
				.builder()
				.aetaNumber(aeta.getAetaNumber())
				.title(aeta.getTitle())
				.contents(aeta.getContents())
				.clientId(aeta.getClientId())
				.createdDate(aeta.getCreatedDate())
				.updatedDate(aeta.getCreatedDate())
				.views(aeta.getViews())
				.build();
	}
	


	public String getPwdById(String clientId) {
	    String encryptedPassword = myPageDAO.getPwdById(clientId); // 암호화된 비밀번호를 가져옵니다.
	    System.out.println("!!!encryptedPassword : "+ encryptedPassword);

	    if (encryptedPassword != null) {
	        return encryptedPassword; // 암호화된 비밀번호 반환
	    }
	    return null;
	}

	public ClientsDTO getUserInfo(String clientId) {
		return changeDTO(myPageDAO.getUserInfo(clientId));
	}

	
	public int modifyPwd(ClientsDTO client) {
		String newPassword = hashPassword(client.getPassword());
		client.setPassword(newPassword);
		int result = myPageDAO.modifyPwd(changeEntity(client));
		if (result > 0) {
			return 1;
		}
		return 0;
	}

	public int modifyUserInfo(ClientsDTO client) {
		client.setPhone(client.getPhone());
		client.setAddress(client.getAddress());
		client.setAddressDetail(client.getAddressDetail());
		client.setZipCode(client.getZipCode());

		int result = myPageDAO.modifyUserInfo(changeEntity(client));
		if (result > 0) {
			return 1;
		}
		return 0;
	}
	
	public String updateImage(MultipartFile multipartFile, String clientId) {
		System.out.println("SSSSSmultipartFile : " + multipartFile);
		System.out.println("SSSSSclientId : " + clientId);
		
		
		String newFileName = System.currentTimeMillis() + "." + multipartFile.getContentType().split("/")[1]; // image/jpg
		File file = new File(UPLOADPATH + IMAGEPATH + newFileName);
		try {
			multipartFile.transferTo(file);
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		String newProfile = "." + IMAGEPATH + newFileName;
		
		ClientsDTO client = new ClientsDTO();
		
		client.setClientId(clientId);
		client.setProfileUrl(newProfile);
		
		int result = myPageDAO.modifyProfileURL(changeEntity(client));
		if (result > 0) {
			return "success";
		}
		return "success";
	}
	
	
	
	
	
	private static String hashPassword(String plainTextPassword) {
		// bcrypt 암호화
		return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
	}

	public Clients changeEntity(ClientsDTO client) {
		return Clients.builder()
					.clientId(client.getClientId())
					.name(client.getName())
					.password(client.getPassword())
					.email(client.getEmail())
					.birthday(client.getBirthday())
					.phone(client.getPhone())
					.address(client.getAddress())
					.addressDetail(client.getAddressDetail())
					.zipCode(client.getZipCode())
					.privacyTerms(client.getPrivacyTerms())
					.emailCheck(client.getEmailCheck())
					.activationCheck(client.getActivationCheck())
					.qualifiedCheck(client.getQualifiedCheck())
					.profileUrl(client.getProfileUrl())
					.emailAuth(client.getEmailAuth())
					.socialType(client.getSocialType())
					.socialId(client.getSocialId())
					.build();
	}
	
	   public ClientsDTO changeDTO(Clients client) {
	        return ClientsDTO.builder()
	                .clientId(client.getClientId())
	                .name(client.getName())
	                .password(client.getPassword())
	                .email(client.getEmail())
	                .birthday(client.getBirthday())
	                .phone(client.getPhone())
	                .address(client.getAddress())
	                .addressDetail(client.getAddressDetail())
	                .zipCode(client.getZipCode())
	                .privacyTerms(client.getPrivacyTerms())
	                .emailCheck(client.getEmailCheck())
	                .activationCheck(client.getActivationCheck())
	                .qualifiedCheck(client.getQualifiedCheck())
	                .profileUrl(client.getProfileUrl())
	                .emailAuth(client.getEmailAuth())
	                .socialType(client.getSocialType())
	                .socialId(client.getSocialId())
	                .build();
	    }

}
