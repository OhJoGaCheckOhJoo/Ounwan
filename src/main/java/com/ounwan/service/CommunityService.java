package com.ounwan.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.ounwan.dto.AetaCommentsDTO;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.AetaLikesDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.InbodyDTO;
import com.ounwan.dto.OunwanGramDTO;
import com.ounwan.dto.PaginatingDTO;
import com.ounwan.entity.Aeta;
import com.ounwan.entity.AetaLikes;
import com.ounwan.entity.Comments;
import com.ounwan.entity.Inbody;
import com.ounwan.entity.OunwanGram;
import com.ounwan.entity.OunwanGramLikes;
import com.ounwan.repository.CommunityDAO;

@Service
public class CommunityService {

	@Autowired
	CommunityDAO communityDAO;
	
	@Autowired
	AmazonS3 amazonS3;

	
	private static final String BUCKET = "ounwan";
	// 이미지 저장 경로 지정
	private final static String UPLOADPATH = "C:/shinhan/sts-workspace/ounwan/src/main/webapp/resources";
	private final static String IMAGEPATH = "/images/uploads/";
	public static final String AETA_UPLOADPATH = "/Users/jungwoo/git/ounwan/src/main/webapp/resources";
	private final static String AETAIMAGEPATH = "/images/aetaUploads/";

	public OunwanGramDTO selectOunwangramBoardDetail(int communityNumber, String clientId) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("communityNumber", communityNumber);
		data.put("clientId", clientId);
		OunwanGramDTO ounwangram = changeOunwanGram(communityDAO.selectOunwangramBoardDetail(data));
		ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
		return ounwangram;
	}

	public int addFollowing(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("relationId", profileId + "-" + clientId);
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.addFollowing(data);
	}

	public int cancelFollowing(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.cancelFollowing(data);
	}

	public int checkFollowing(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.checkFollow(data);
	}

	public Map<String, Object> getProfile(String profileId) {
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("image", communityDAO.getProfileImage(profileId));
		result.put("clientId", profileId);
		return result;
	}

	public Map<String, Object> updateInbody(String clientId, InbodyDTO inbody) {
		inbody.setClientId(clientId);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("clientId", clientId);
		if (communityDAO.updateInbody(changeInbodyEntity(inbody)) > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}

	public Map<String, Object> insertInbody(String clientId, InbodyDTO inbody) {
		inbody.setClientId(clientId);
		Map<String, Object> result = new HashMap<String, Object>();
		result.put("clientId", clientId);
		if (communityDAO.insertInbody(changeInbodyEntity(inbody)) > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}

	public List<Map<String, Object>> selectFollowerList(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.selectFollowerList(data);
	}

	public List<Map<String, Object>> selectFollowingList(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.selectFollowingList(data);
	}

	public List<InbodyDTO> selectMyInbodyInfo(String clientId) {
		List<InbodyDTO> result = new ArrayList<>();
		for (Inbody inbody : communityDAO.selectMyInbody(clientId)) {
			result.add(changeInbody(inbody));
		}
		return result;
	}

	public Map<String, Object> selectMyInbodyGraph(String clientId) {
		Map<String, Object> inbodyData = new HashMap<>();
		List<Object> weight = new ArrayList<>();
		List<Object> skeletalMusclesMass = new ArrayList<>();
		List<Object> bodyWater = new ArrayList<>();
		List<Object> bmr = new ArrayList<>();
		List<Object> bmi = new ArrayList<>();
		List<Object> inbodyScore = new ArrayList<>();
		List<Object> updatedDate = new ArrayList<>();

		for (Inbody inbody : communityDAO.selectMyInbody(clientId)) {
			weight.add(0, inbody.getWeight());
			skeletalMusclesMass.add(0, inbody.getSkeletalMusclesMass());
			bodyWater.add(0, inbody.getBodyWater());
			bmr.add(0, inbody.getBmr());
			bmi.add(0, inbody.getBmi());
			inbodyScore.add(0, inbody.getInbodyScore());
			updatedDate.add(0, inbody.getUpdatedDate().toString());
		}
		inbodyData.put("weight", weight);
		inbodyData.put("skeletalMusclesMass", skeletalMusclesMass);
		inbodyData.put("bodyWater", bodyWater);
		inbodyData.put("bmr", bmr);
		inbodyData.put("bmi", bmi);
		inbodyData.put("inbodyScore", inbodyScore);
		inbodyData.put("updatedDate", updatedDate);
		return inbodyData;
	}
	
	public List<Map<String, Object>> getReportGramBoard(int offset) {
		List<Map<String, Object>> result = new ArrayList<>();
		
		for(Map<String, Object> reportBoard : communityDAO.getAdminReportBoard(offset)) {
			reportBoard.put("reportInfo", communityDAO.getAdminReportReason((int)reportBoard.get("COMMUNITY_NUMBER")));
			reportBoard.put("hashTags",  communityDAO.hashTagsByNumber((int)reportBoard.get("COMMUNITY_NUMBER")));
			result.add(reportBoard);
		}
		return result;
	}
	
	public int getReportGramCount() {
		int pages = communityDAO.getReportGramCount();
		return pages / 20 + (pages % 20 > 0 ? 1 : 0);
	}
	
	public String updateGramBoard(int communityNumber, boolean status) {
		return (status ? communityDAO.updateAdminGramVisibility(communityNumber) : communityDAO.updateGramVisibility(communityNumber)) > 0 ? "success" : "fail";
	}

	public String reportBoard(String clientId, int communityNumber, int[] reason) {
		Map<String, Object> data = new HashMap<>();
		String[] stringReason = {
				"스팸홍보/도배글입니다.",
				"음란물입니다.",
				"불법정보를 포함하고 있습니다.",
				"청소년에게 유해한 내용입니다.",
				"욕설/생명경시/혐오/차별적 게시물입니다.",
				"개인정보 노출 게시물입니다.",
				"불쾌한 표현이 있습니다.",
				"불법촬영물 등이 포함되어 있습니다.",
				"게시물 디테일에서 신고"
		};
		StringBuilder reasonBuilder = new StringBuilder();
		for (int i : reason) {
			reasonBuilder.append(stringReason[i]);
		}
		data.put("clientId", clientId);
		data.put("communityNumber", communityNumber);
		data.put("reason", reasonBuilder.toString());
		if (communityDAO.reportBoard(data) > 0) {
			if(communityDAO.countGramReports(communityNumber) % 5 == 0) {
				communityDAO.updateGramVisibility(communityNumber);
			}
			return "success";
		} else {
			return "fail";
		}
	}
	
	public String updateAdminGramVisibility(int communityNumber) {
		return communityDAO.updateAdminGramVisibility(communityNumber) > 0 ? "success" : "fail";
	}

	public List<OunwanGramDTO> gramFollowBoard(String clientId, int rowNum) {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("clientId", clientId);
		dataMap.put("rowNum", rowNum);
		List<OunwanGramDTO> result = new ArrayList<OunwanGramDTO>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);

		for (OunwanGram ounwangram : communityDAO.gramFollowBoard(dataMap)) {
			ounwangram.setLikesCheck(likeBoars.contains(ounwangram.getCommunityNumber()) ? 1 : 0);
			ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
			OunwanGramDTO ounwangramDTO = changeOunwanGram(ounwangram);
			ounwangramDTO.setMine(false);
			result.add(ounwangramDTO);
		}

		return result;
	}

	public List<OunwanGramDTO> gramWholeBoard(String clientId, int rowNum) {
		List<OunwanGramDTO> result = new ArrayList<OunwanGramDTO>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("clientId", clientId);
		data.put("rowNum", rowNum);
		for (OunwanGram ounwangram : communityDAO.gramWholeBoard(rowNum)) {
			ounwangram.setLikesCheck(likeBoars.contains(ounwangram.getCommunityNumber()) ? 1 : 0);
			ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
			OunwanGramDTO ounwangramDTO = changeOunwanGram(ounwangram);
			if (ounwangramDTO.getClientId().equals(clientId)) {
				ounwangramDTO.setMine(true);
			} else {
				ounwangramDTO.setMine(false);
			}
			result.add(ounwangramDTO);
		}
		return result;
	}

	@SuppressWarnings("static-access")
	public Map<String, Integer> gramLikeBoard(String clientId, int communityNumber) {
		Map<String, Integer> result = new HashMap<String, Integer>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);
		if (likeBoars.contains(communityNumber)) {
			if (communityDAO.cancelLikeOunwanBoard(communityNumber + "-" + clientId) > 0) {
				result.put("likesCheck", 0);
			} else {
				result.put("likesCheck", 2);
			}

		} else {
			if (communityDAO
					.addLikeOunwanBoard(new OunwanGramLikes().builder().likesId(communityNumber + "-" + clientId)
							.communityNumber(communityNumber).clientId(clientId).build()) > 0) {
				result.put("likesCheck", 1);
			} else {
				result.put("likesCheck", 2);
			}
		}
		result.put("likes", communityDAO.aGramBoard(communityNumber).getLikes());
		return result;
	}

	public OunwanGramDTO aGramBoard(int communityNumber) {
		OunwanGram ounwangram = communityDAO.aGramBoard(communityNumber);
		ounwangram.setHashTags(communityDAO.hashTagsByNumber(communityNumber));
		return changeOunwanGram(ounwangram);
	}

	public String deleteGramBoard(int communityNumber) {
		new File(UPLOADPATH + communityDAO.selectBoardByCommunityNum(communityNumber).getImageUrl().substring(1))
				.delete();
		return communityDAO.deleteGramBoard(communityNumber) > 0 ? "success" : "fail";
	}

	public String gramWriteBoard(String clientId, MultipartFile image, String content, String[] hashTag)
			throws IllegalStateException, IOException {
		String newFileName = clientId + "_" + System.currentTimeMillis() + "." + image.getContentType().split("/")[1]; // image/jpg
		
		ObjectMetadata metadata = new ObjectMetadata();
		metadata.setContentLength(image.getSize());
		metadata.setContentType(image.getContentType());
		
		amazonS3.putObject(BUCKET, newFileName, image.getInputStream(), metadata);
		
		String imageUrl = amazonS3.getUrl(BUCKET, newFileName).toString();
		
		OunwanGram board = OunwanGram.builder()
										.clientId(clientId)
										.contents(content.length() > 0 ? content : null)
										.imageUrl(imageUrl)
										.build();
		
		if (communityDAO.writeGramBoard(board) > 0) {
			Map<String, Object> data = new HashMap<String, Object>();
			data.put("communityNumber", board.getCommunityNumber());
			for (String name : hashTag) {
				data.put("name", name);
				communityDAO.insertHashTagName(name);
				communityDAO.addHashTag(data);
			}
			return "success";
		} else {
			return "fail";
		}
	}

	public List<Map<String, Object>> searchAjaxGram(String keyword) {
		List<Map<String, Object>> result = communityDAO.searchGramClientId(keyword);
		result.add(0, communityDAO.searchHashTag(keyword));
		return result;
	}

	public Map<String, Object> getUserProfile(String profileId, String clientId) {
		Map<String, Object> result = communityDAO.getUserProfileInfo(profileId);
		if (!profileId.equals(clientId)) {
			Map<String, Object> data = new HashMap<>();
			data.put("profileId", profileId);
			data.put("clientId", clientId);
			result.put("check", communityDAO.checkFollow(data) > 0 ? true : false);
		}
		return result;
	}

	public List<Map<String, Object>> getUserBoards(String profileId, String clientId) {
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("profileId", profileId);
		data.put("clientId", clientId);
		return communityDAO.getProfileBoard(data);
	}

	public String gramUpdateBoard(String clientId, int communityNumber, MultipartFile image, String content,
			String[] hashTag) throws IllegalStateException, IOException {
		OunwanGram ounwanBoard = communityDAO.selectBoardByCommunityNum(communityNumber);
		ounwanBoard.setContents(content); 

		if (image != null) {
			File removeFile = new File(UPLOADPATH + ounwanBoard.getImageUrl().substring(1));
			amazonS3.deleteObject(BUCKET, ounwanBoard.getImageUrl());
			
			String newFileName = clientId + "_" + System.currentTimeMillis() + "." + image.getContentType().split("/")[1]; // image/jpg
			
			ObjectMetadata metadata = new ObjectMetadata();
			metadata.setContentLength(image.getSize());
			metadata.setContentType(image.getContentType());
			
			amazonS3.putObject(BUCKET, newFileName, image.getInputStream(), metadata);
			
			String imageUrl = amazonS3.getUrl(BUCKET, newFileName).toString();
			
			ounwanBoard.setImageUrl(imageUrl);
		}

		// 태그 업데이트
		tagUpdate(communityNumber, hashTag);
		// DB 반영
		if (communityDAO.updateGramBoard(ounwanBoard) > 0) {
			return "success";
		} else {
			return "fail";
		}
	}

	public int tagUpdate(int communityNumber, String[] hashTag) {
		Map<String, Object> dataMap = new HashMap<String, Object>();
		dataMap.put("communityNumber", communityNumber);
		int result = 1;

		for (String name : communityDAO.hashTagsByNumber(communityNumber)) {
			dataMap.put("name", name);
			result *= communityDAO.removeTag(dataMap);
		}

		for (String name : hashTag) {
			dataMap.put("name", name);
			result *= communityDAO.insertHashTagName(name);
			result *= communityDAO.addHashTag(dataMap);
		}
		return result;
	}

	public List<OunwanGramDTO> searchByTag(String clientId, int rowNum, String name) {
		Map<String, Object> data = new HashMap<String, Object>();
		List<OunwanGramDTO> result = new ArrayList<OunwanGramDTO>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);

		data.put("rowNum", rowNum);
		data.put("name", name);

		for (OunwanGram ounwangram : communityDAO.selectBoardsByTag(data)) {
			ounwangram.setLikesCheck(likeBoars.contains(ounwangram.getCommunityNumber()) ? 1 : 0);
			ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
			OunwanGramDTO ounwangramDTO = changeOunwanGram(ounwangram);
			if (ounwangramDTO.getClientId().equals(clientId)) {
				ounwangramDTO.setMine(true);
			} else {
				ounwangramDTO.setMine(false);
			}
			result.add(ounwangramDTO);
		}
		return result;
	}

	@SuppressWarnings("static-access")
	public OunwanGramDTO changeOunwanGram(OunwanGram ounwangram) {
		return OunwanGramDTO.builder().communityNumber(ounwangram.getCommunityNumber())
				.clientId(ounwangram.getClientId()).contents(ounwangram.getContents())
				.createdDate(ounwangram.getCreatedDate()).updatedDate(ounwangram.getUpdatedDate())
				.likes(ounwangram.getLikes()).imageUrl(ounwangram.getImageUrl()).profileUrl(ounwangram.getProfileUrl())
				.likesCheck(ounwangram.getLikesCheck()).hashTags(ounwangram.getHashTags()).build();
	}

	@SuppressWarnings("static-access")
	public OunwanGram changeOunwanGramEntity(OunwanGramDTO ounwangram) {
		return OunwanGram.builder().communityNumber(ounwangram.getCommunityNumber()).clientId(ounwangram.getClientId())
				.contents(ounwangram.getContents()).createdDate(ounwangram.getCreatedDate())
				.updatedDate(ounwangram.getUpdatedDate()).likes(ounwangram.getLikes())
				.imageUrl(ounwangram.getImageUrl()).profileUrl(ounwangram.getProfileUrl())
				.likesCheck(ounwangram.getLikesCheck()).hashTags(ounwangram.getHashTags()).build();
	}

	public InbodyDTO changeInbody(Inbody inbody) {
		return InbodyDTO.builder().inbodyNumber(inbody.getInbodyNumber()).clientId(inbody.getClientId())
				.height(inbody.getHeight()).weight(inbody.getWeight())
				.skeletalMusclesMass(inbody.getSkeletalMusclesMass()).bodyWater(inbody.getBodyWater())
				.bmr(inbody.getBmr()).bmi(inbody.getBmi()).inbodyScore(inbody.getInbodyScore())
				.updatedDate(inbody.getUpdatedDate()).build();
	}

	public Inbody changeInbodyEntity(InbodyDTO inbody) {
		return Inbody.builder().inbodyNumber(inbody.getInbodyNumber()).clientId(inbody.getClientId())
				.height(inbody.getHeight()).weight(inbody.getWeight())
				.skeletalMusclesMass(inbody.getSkeletalMusclesMass()).bodyWater(inbody.getBodyWater())
				.bmr(inbody.getBmr()).bmi(inbody.getBmi()).inbodyScore(inbody.getInbodyScore())
				.updatedDate(inbody.getUpdatedDate()).build();
	}

	int pageLimit = 10; 
	int blockLimit = 10; 

	public List<AetaDTO> aetaList(int page, String inputValue, String selectedOption) {

		int pageStartNum = (page - 1) * pageLimit;

		Map<String, Object> paginateParams = new HashMap<String, Object>();

		paginateParams.put("start", pageStartNum);
		paginateParams.put("limit", pageLimit);
		paginateParams.put("inputValue", inputValue);

		if (selectedOption.equals("aetaSearchAll"))
			return changeDTOList(communityDAO.aetaSearchAll(paginateParams));
		if (selectedOption.equals("aetaSearchTitle"))
			return changeDTOList(communityDAO.aetaSearchTitle(paginateParams));
		if (selectedOption.equals("aetaSearchId"))
			return changeDTOList(communityDAO.aetaSearchId(paginateParams));
		return changeDTOList(communityDAO.AetaList(paginateParams)); // 애타 게시판메인
	}

	public PaginatingDTO getPages(int page, String inputValue, String selectedOption) {
		int countPosts = 0;
		switch (selectedOption) {
		
		case "aetaSearchAll":
			countPosts = communityDAO.CountSearchAll(inputValue);
			break;
		case "aetaSearchTitle":
			countPosts = communityDAO.CountSearchTitle(inputValue);
			break;
		case "aetaSearchId":
			countPosts = communityDAO.CountSearchId(inputValue);
			break;
		default:
			countPosts = communityDAO.CountSearchAll(inputValue);
			break;
		}

		int maxPageNumber = (int) (Math.ceil((double) countPosts / pageLimit));
		int startPageNumber = (((int) (Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
		int endPageNumber = startPageNumber + blockLimit - 1;
		if (endPageNumber > maxPageNumber) {
			endPageNumber = maxPageNumber;
		}

		return PaginatingDTO.builder().pageNumber(page).maxPageNumber(maxPageNumber).startPageNumber(startPageNumber)
				.endPageNumber(endPageNumber).build();
	}

	public int aetaInsertPost(HttpSession session, String title, String contents, MultipartFile[] images,
			Integer imagesLength) throws IllegalStateException, IOException {
		ClientsDTO user = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = (user.getClientId());
		Integer count = imagesLength;

		int result = 0;

		communityDAO.aetaInsertPost(
				changeEntity(AetaDTO.builder().clientId(clientId).title(title).contents(contents).build()));

		if (images == null) {
			imagesLength = 0;
		}
		if (imagesLength > 0) {
			String[] aetaFileNames = aetaMakeFileName(clientId, images, imagesLength, count);
			aetaFileNames = aetaUploadFiles(images, imagesLength, aetaFileNames, count);
			result = aetaInsertImageUrls(imagesLength, aetaFileNames, count);
		}
		return result == imagesLength ? 1 : 0;
	}

	public int aetaUpdatePost(HttpSession session, int aetaNumber, String title, String contents,
			MultipartFile[] newImages, int newImagesLength) throws IllegalStateException, IOException {
		
		ClientsDTO user = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = (user.getClientId());
		System.out.println(clientId);
		int result = 0;
		
		int count = newImagesLength;

		communityDAO.aetaUpdatePost(changeEntity(AetaDTO.builder()
														.clientId(clientId)
														.aetaNumber(aetaNumber)
														.title(title)
														.contents(contents)
														.build()));
		if (newImages == null) {
			newImagesLength = 0;
		}else{
			String[] aetaFileNames = aetaMakeFileName(clientId, newImages, newImagesLength, count);
			aetaFileNames = aetaUploadFiles(newImages, newImagesLength, aetaFileNames, count);
			result = aetaUpdateImageUrls(aetaNumber, newImagesLength, aetaFileNames, count);
		}
		return result == newImagesLength ? 1 : 0;
	}

	private int aetaUpdateImageUrls(int aetaNumber, int newImagesLength, String[] aetaFileNames, int count) {
		int countImages = 0;
		Map<String, Object> aetaUrlMap = new HashMap<>();
		aetaDeleteImageUrls(aetaNumber);
		for (int i = (count - newImagesLength); i < count; i++) {
			aetaUrlMap.put("aetaNumber", aetaNumber);
			aetaUrlMap.put("url", aetaFileNames[i]);
			countImages += communityDAO.aetaInsertImageUrls(aetaUrlMap);
		}
		return countImages;
	}

	private int aetaDeleteImageUrls(int aetaNumber) {
		return communityDAO.aetaDeleteImageUrls(aetaNumber);
	}

	private String[] aetaMakeFileName(String clientId, MultipartFile[] images, int imagesLength, int count) {
		String[] aetaFileNames = new String[imagesLength];
		for (int i = (count - imagesLength); i < count; i++) {
			aetaFileNames[i] = clientId + "_" + System.currentTimeMillis() + "_" + i + "."
					+ images[i].getContentType().split("/")[1]; // ex) jj1234_시간_1.png
		}
		return aetaFileNames;
	}

	// 이미지 업로드 메소드
	public String[] aetaUploadFiles(MultipartFile[] images, int imagesLength, String[] aetaFileNames, int count) 
			throws IllegalStateException, IOException {
		// 저장할 파일 이름과 파일저장 배열 선언
		File[] aetaUploadFiles = new File[imagesLength];

		for (int i = (count - imagesLength); i < count; i++) {
			ObjectMetadata metadata = new ObjectMetadata();
			metadata.setContentLength(images[i].getSize());
			metadata.setContentType(images[i].getContentType());
			
			amazonS3.putObject(BUCKET, aetaFileNames[i], images[i].getInputStream(), metadata);
			
			aetaFileNames[i] = amazonS3.getUrl(BUCKET, aetaFileNames[i]).toString();
		}
		return aetaFileNames;
	}

	private int aetaInsertImageUrls(int imagesLength, String[] aetaFileNames, int count) {
		int countImages = 0;
		Map<String, Object> aetaUrlMap = new HashMap<>();

		for (int i = (count - imagesLength); i < count; i++) {
			aetaUrlMap.put("url", aetaFileNames[i]);
			countImages += communityDAO.aetaInsertImageUrls(aetaUrlMap);
		}
		return countImages;
	}

	public List<Map<String, Object>> aetaReadPost(int aetaNumber) {
		return communityDAO.aetaReadPost(aetaNumber);
	}
	
	public List<Map<String,Object>> aetaReadComments(int aetaNumber){
		return communityDAO.aetaReadComments(aetaNumber);
	}

	public int aetaCountComments(int aetaNumber) {
		return communityDAO.aetaCountComments(aetaNumber);
	}

	public boolean aetaUpdateViews(int aetaNumber) {
		return (communityDAO.aetaUpdateViews(aetaNumber) > 0) ? true : false;
	}

	public int aetaCountLikes(int aetaNumber) {
		return communityDAO.aetaCountLikes(aetaNumber);
	}

	public int aetaLikesCheck(int aetaNumber, String clientId) {
		return communityDAO
				.aetaLikesCheck(changeEntity(AetaLikesDTO.builder().aetaNumber(aetaNumber).clientId(clientId).build()));
	}

	public AetaLikesDTO aetaLikesButton(int aetaNumber, ClientsDTO user) {
		AetaLikesDTO data = AetaLikesDTO.builder().aetaNumber(aetaNumber).clientId(user.getClientId()).build();

		int checkLikes = communityDAO.aetaLikesCheck(changeEntity(data));
		Boolean like = null;
		Boolean dislike = null;
		if (checkLikes == 0) {
			like = (communityDAO.aetaLike(changeEntity(data)) > 0) ? true : false;
		} else {
			dislike = (communityDAO.aetaDislike(changeEntity(data)) > 0) ? true : false;
		}
		int count = communityDAO.aetaCountLikes(aetaNumber);
		return AetaLikesDTO.builder().like(like).dislike(dislike).likesCount(count).build();
	}

	public List<Map<String, Object>> aetaPostToBeUpdated(int aetaNumber) {
		return communityDAO.aetaPostToBeUpdated(aetaNumber);
	}

	public int aetaDeletePost(AetaDTO post) {
		int result = communityDAO.aetaDeletePost(post.getAetaNumber());
		return result;
	}

	public int aetaReport(AetaDTO aeta) {
		return communityDAO.aetaReport(changeEntity(aeta));
	}

	public boolean aetaInsertComment(AetaCommentsDTO comment) {
		return (communityDAO.aetaInsertComment(changeEntity(comment)) > 0) ? true : false;
	}

	public boolean aetaDeleteComment(AetaCommentsDTO comment) {
		Comments c = changeEntity(comment);
		return (communityDAO.aetaDeleteComment(changeEntity(comment)) > 0) ? true : false;
	}

	public String findClientId(int aetaNumber) {
		return communityDAO.findClientId(aetaNumber);
	}
	
	public List<AetaDTO> getAetaReportList() {
		return changeDTOList(communityDAO.getAetaReportList());
	}
	
	public boolean restoreAeta(Integer aetaNumber) {
		int result = communityDAO.restoreAeta(aetaNumber);
		return (result > 0) ? true : false;
	}
	
	public boolean adminAetaDelete(int aetaNumber) {
		int result = communityDAO.adminAetaDelete(aetaNumber);
		return (result > 0) ? true : false;
	}

	private Aeta changeEntity(AetaDTO aeta) {
		return Aeta.builder()
					.aetaNumber(aeta.getAetaNumber())
					.title(aeta.getTitle())
					.contents(aeta.getContents())
					.clientId(aeta.getClientId())
					.createdDate(aeta.getCreatedDate())
					.updatedDate(aeta.getCreatedDate())
					.views(aeta.getViews())
					.visibility(aeta.getVisibility())
					.reportReason(aeta.getReportReason())
					.build();
	}


	private Comments changeEntity(AetaCommentsDTO comment) {
		return Comments.builder()
						.clientId(comment.getClientId())
						.commentNumber(comment.getCommentNumber())
						.aetaNumber(comment.getAetaNumber())
						.contents(comment.getContents())
						.createdDate(comment.getCreatedDate())
						.updatedDate(comment.getUpdatedDate())
						.build();
	}

	private List<AetaDTO> changeDTOList(List<Aeta> boardList) {
		List<AetaDTO> list = new ArrayList<AetaDTO>();

		for (Aeta aeta : boardList) {
			list.add(changeDTO(aeta));
		}
		return list;
	}

	private AetaDTO changeDTO(Aeta aeta) {
		return AetaDTO.builder()
						.aetaNumber(aeta.getAetaNumber())
						.title(aeta.getTitle())
						.contents(aeta.getContents())
						.clientId(aeta.getClientId())
						.createdDate(aeta.getCreatedDate())
						.updatedDate(aeta.getCreatedDate())
						.views(aeta.getViews())
						.visibility(aeta.getVisibility())
						.reportReason(aeta.getReportReason())
						.build();
	}

	private AetaLikes changeEntity(AetaLikesDTO aetaLikesDTO) {
		return AetaLikes.builder()
						.likeNumber(aetaLikesDTO.getLikeNumber())
						.aetaNumber(aetaLikesDTO.getAetaNumber())
						.clientId(aetaLikesDTO.getClientId())
						.build();
	}

	public int aetaBlindPost(int aetaNumber) {
		return communityDAO.aetaBlindPost(aetaNumber);
	}

}
