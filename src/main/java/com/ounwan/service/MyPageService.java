package com.ounwan.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.DanggunChatRoomDTO;
import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.PaginatingDTO;
import com.ounwan.entity.Aeta;
import com.ounwan.entity.Clients;
import com.ounwan.entity.Danggun;
import com.ounwan.entity.DanggunChatRoom;
import com.ounwan.repository.ClientsDAO;
import com.ounwan.repository.MyPageDAO;

@Service
public class MyPageService {

	@Autowired
	MyPageDAO myPageDAO;

	@Autowired
	ClientsDAO clientsDAO;
	
	@Autowired
	AmazonS3 amazonS3;
	
	private static final String BUCKET = "ounwan";
	private static final String DEFAULT_PROFILE = "https://ounwan.s3.ap-northeast-2.amazonaws.com/1704123555189.png";
	private static final int PAGELIMIT = 10; 
	private static final int BLOCKLIMIT = 10;
	
	public boolean changeConfirmState(String orderNumber) {
		int stateChange = myPageDAO.changeConfirmState(orderNumber);
		return stateChange>0? true : false;
	}
	
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

		for (String wishList : selectWishLists) {
			myPageDAO.deleteWishList(Integer.parseInt(wishList));
			result++;
		}
		return selectWishLists.size() == result ? true : false;
	}

	public List<AetaDTO> getAetaList(String userId,int page) {
		Map<String,Object> userPosts=new HashMap<>();
		userPosts.put("clientId", userId);
		userPosts.put("start",(page-1)*PAGELIMIT);
		userPosts.put("limit",PAGELIMIT);

		return changeDTOList(myPageDAO.getAetaList(userPosts));
	}

	public PaginatingDTO getPages(int page, String userId) {
		int countPosts = myPageDAO.countAetaList(userId);
		int maxPageNumber = (int) (Math.ceil((double) countPosts / PAGELIMIT));
		int startPageNumber = (((int) (Math.ceil((double) page / BLOCKLIMIT))) - 1) * BLOCKLIMIT + 1;
		int endPageNumber = startPageNumber + BLOCKLIMIT - 1;
		if (endPageNumber > maxPageNumber) {
			endPageNumber = maxPageNumber;
		}
		return PaginatingDTO.builder().pageNumber(page).maxPageNumber(maxPageNumber).startPageNumber(startPageNumber).endPageNumber(endPageNumber).build();
	}

	public List<Map<String, Object>> getReviewList(String userId) {
		return myPageDAO.getReviewList(userId);
	}

	public boolean deleteReviewList(List<String> selectedReviews) {
		int result = 0;
		for (String reviewNumber : selectedReviews) {
			myPageDAO.deleteReviewList(Integer.parseInt(reviewNumber));
			result++;
		}
		return selectedReviews.size() == result ? true : false;
	}

	public String getPwdById(String clientId) {
		String encryptedPassword = myPageDAO.getPwdById(clientId); 
		
		if (encryptedPassword != null) {
			return encryptedPassword; 
		}
		return null;
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
	
	public ClientsDTO modifyUserInfo(ClientsDTO client) {
		int result = myPageDAO.modifyUserInfo(changeEntity(client));
		if (result > 0) {
			return changeDTO(myPageDAO.getUserInfo(client.getClientId()));
		}
		return null;
	}

	public ClientsDTO updateImage(MultipartFile multipartFile, ClientsDTO client) throws IllegalStateException, IOException {
		String newFileName = System.currentTimeMillis() + "." + multipartFile.getContentType().split("/")[1]; // image/jpg
		
		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentLength(multipartFile.getSize());
		metadata.setContentType(multipartFile.getContentType());
		
		if (!client.getProfileUrl().equals(DEFAULT_PROFILE))
			amazonS3.deleteObject(BUCKET, client.getProfileUrl());
	
		amazonS3.putObject(BUCKET, newFileName, multipartFile.getInputStream(), metadata);
		
		String newProfile = amazonS3.getUrl(BUCKET, newFileName).toString();

		int result = myPageDAO.modifyProfileURL(Clients.builder()
														.clientId(client.getClientId())
														.profileUrl(newProfile)
														.build());
		if (result > 0) 
			client.setProfileUrl(newProfile);
		else 
			client.setProfileUrl(null);
		
		return client;
	}

	public int withdrawUserInfo(ClientsDTO client) {
		client.setPrivacyTerms(client.getPrivacyTerms());
		client.setActivationCheck(client.getActivationCheck());
		
		int result = myPageDAO.withdrawUserInfo(changeEntity(client));
		if(result > 0) {
			return 1;
		} 
		return 0;
	}

	public List<DanggunChatRoomDTO> changeDTOList2(List<DanggunChatRoom> danggunChatRoom) {
		List<DanggunChatRoomDTO> changeList = new ArrayList<>();
		for (DanggunChatRoom data : danggunChatRoom) {
			changeList.add(changeDTO(data));
		}
		return changeList;
	}

	private DanggunChatRoomDTO changeDTO(DanggunChatRoom danggunChatRoom) {
		return DanggunChatRoomDTO.builder().roomId(danggunChatRoom.getRoomId())
				.danggunNumber(danggunChatRoom.getDanggunNumber()).seller(danggunChatRoom.getSeller())
				.buyer(danggunChatRoom.getBuyer()).build();
	}

	private static String hashPassword(String plainTextPassword) {
		return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
	}

	public DanggunDTO changeDTO(Danggun danggun) {
		return DanggunDTO.builder().danggunNumber(danggun.getDanggunNumber())
				.tradeHistoryNumber(danggun.getTradeHistoryNumber()).clientId(danggun.getClientId())
				.productName(danggun.getProductName()).price(danggun.getPrice()).detail(danggun.getDetail())
				.uploadDate(danggun.getUploadDate()).build();
	}

	public List<AetaDTO> changeDTOList(List<Aeta> aeta) {
		List<AetaDTO> changeList = new ArrayList<>();
		for (Aeta data : aeta) {
			changeList.add(changeDTO(data));
		}
		return changeList;
	}

	public AetaDTO changeDTO(Aeta aeta) {
		return AetaDTO.builder().aetaNumber(aeta.getAetaNumber()).title(aeta.getTitle()).contents(aeta.getContents())
				.clientId(aeta.getClientId()).createdDate(aeta.getCreatedDate()).updatedDate(aeta.getCreatedDate())
				.views(aeta.getViews()).build();
	}

	public Clients changeEntity(ClientsDTO client) {
		return Clients.builder().clientId(client.getClientId()).name(client.getName()).password(client.getPassword())
				.email(client.getEmail()).birthday(client.getBirthday()).phone(client.getPhone())
				.address(client.getAddress()).addressDetail(client.getAddressDetail()).zipCode(client.getZipCode())
				.privacyTerms(client.getPrivacyTerms()).emailCheck(client.getEmailCheck())
				.activationCheck(client.getActivationCheck()).qualifiedCheck(client.getQualifiedCheck())
				.profileUrl(client.getProfileUrl()).emailAuth(client.getEmailAuth()).socialType(client.getSocialType())
				.socialId(client.getSocialId()).build();
	}

	public ClientsDTO changeDTO(Clients client) {
		return ClientsDTO.builder().clientId(client.getClientId()).name(client.getName()).password(client.getPassword())
				.email(client.getEmail()).birthday(client.getBirthday()).phone(client.getPhone())
				.address(client.getAddress()).addressDetail(client.getAddressDetail()).zipCode(client.getZipCode())
				.privacyTerms(client.getPrivacyTerms()).emailCheck(client.getEmailCheck())
				.activationCheck(client.getActivationCheck()).qualifiedCheck(client.getQualifiedCheck())
				.profileUrl(client.getProfileUrl()).emailAuth(client.getEmailAuth()).socialType(client.getSocialType())
				.socialId(client.getSocialId()).build();
	}

}
