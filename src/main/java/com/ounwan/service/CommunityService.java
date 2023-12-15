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

import com.ounwan.dto.OunwanGramDTO;
import com.ounwan.entity.OunwanGram;
import com.ounwan.entity.OunwanGramLikes;
import com.ounwan.repository.CommunityDAO;

@Service
public class CommunityService {
	
	@Autowired
	CommunityDAO communityDAO;
	
	private final static String UPLOADPATH = "C:/shinhan/sts-workspace/ounwan/src/main/webapp/resources";
	private final static String IMAGEPATH = "/images/uploads/";
	
	public Map<String, Object> selectMyInbody(String clientId) {
		System.out.println(communityDAO.selectMyInbody(clientId).toString());
		return null;
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
				"불법촬영물 등이 포함되어 있습니다."
		};
		StringBuilder reasonBuilder = new StringBuilder();
		for(int i : reason) {
			reasonBuilder.append(stringReason[i]);
		}
		data.put("clientId", clientId);
		data.put("communityNumber", communityNumber);
		data.put("reason", reasonBuilder.toString());
		if(communityDAO.reportBoard(data) > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	public List<OunwanGramDTO> gramFollowBoard(String clientId, int rowNum) {
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("clientId", clientId);
		dataMap.put("rowNum", rowNum);
		List<OunwanGramDTO> result = new ArrayList<>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);

		for(OunwanGram ounwangram : communityDAO.gramFollowBoard(dataMap)) {
			ounwangram.setLikesCheck(likeBoars.contains(ounwangram.getCommunityNumber()) ? 1 : 0);
			ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
			OunwanGramDTO ounwangramDTO = changeOunwanGram(ounwangram);
			ounwangramDTO.setMine(false);
			result.add(ounwangramDTO);
		}

		return result;
	}

	public List<OunwanGramDTO> gramWholeBoard(String clientId, int rowNum) {
		List<OunwanGramDTO> result = new ArrayList<>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);
		Map<String, Object> data = new HashMap<>();
		data.put("clientId", clientId);
		data.put("rowNum", rowNum);
		for(OunwanGram ounwangram : communityDAO.gramWholeBoard(rowNum)) {
			ounwangram.setLikesCheck(likeBoars.contains(ounwangram.getCommunityNumber()) ? 1 : 0);
			ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
			OunwanGramDTO ounwangramDTO = changeOunwanGram(ounwangram);
			if(ounwangramDTO.getClientId().equals(clientId)) {
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
		Map<String, Integer> result = new HashMap<>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);
		if(likeBoars.contains(communityNumber)) {
			if(communityDAO.cancelLikeOunwanBoard(communityNumber + "-" + clientId) > 0) {
				result.put("likesCheck", 0);
			} else {
				result.put("likesCheck", 2);
			}
			
		} else {
			if(communityDAO.addLikeOunwanBoard(new OunwanGramLikes().builder()
					.likesId(communityNumber + "-" + clientId)
					.communityNumber(communityNumber)
					.clientId(clientId)
					.build()) > 0) {
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
		new File(UPLOADPATH + communityDAO.selectBoardByCommunityNum(communityNumber).getImageUrl().substring(1)).delete();
		return communityDAO.deleteGramBoard(communityNumber) > 0 ? "success" : "fail";
	}

	public String gramWriteBoard(String clientId, MultipartFile image, String content, String[] hashTag) throws IllegalStateException, IOException {
		String newFileName = clientId + "_" + System.currentTimeMillis() + "." + image.getContentType().split("/")[1]; // image/jpg
		File file = new File(UPLOADPATH + IMAGEPATH + newFileName);
		OunwanGram board = OunwanGram.builder()
									.clientId(clientId)
									.contents(content.length() > 0 ? content : null)
									.imageUrl("." + IMAGEPATH + newFileName)
									.build();
		if(communityDAO.writeGramBoard(board) > 0) {
			image.transferTo(file);
			Map<String, Object> data = new HashMap<>();
			data.put("communityNumber", board.getCommunityNumber());
			for(String name : hashTag) {
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
		if(!profileId.equals(clientId)) {
			Map<String, Object> data = new HashMap<>();
			data.put("profileId", profileId);
			data.put("clientId", clientId);
			result.put("check", communityDAO.checkFollow(data) > 0 ? true : false);
		}
		return result;
	}
	
	public List<Map<String, Object>> getUserBoards(String profileId, String clientId) {
		Map<String, Object> data = new HashMap<>();
		data.put("profileId", profileId);
		data.put("clientId", clientId);
		return communityDAO.getProfileBoard(data);
	}
	
	public String gramUpdateBoard(String clientId, int communityNumber, MultipartFile image, String content, String[] hashTag) throws IllegalStateException, IOException {
		OunwanGram ounwanBoard = communityDAO.selectBoardByCommunityNum(communityNumber);
		ounwanBoard.setContents(content); // 내용 수정
		
		// 이미지 수정
		if(image != null) {
			File removeFile = new File(UPLOADPATH + ounwanBoard.getImageUrl().substring(1));
			if(removeFile.delete()) {
				String newFileName = clientId + "_" + System.currentTimeMillis() + "." + image.getContentType().split("/")[1]; // image/jpg
				File file = new File(UPLOADPATH + IMAGEPATH + newFileName);
				ounwanBoard.setImageUrl("." + IMAGEPATH + newFileName);
				image.transferTo(file);
			} else {
				return "fail";
			}
		}
		
		// 태그 업데이트
		tagUpdate(communityNumber, hashTag);
		
		// DB 반영
		if(communityDAO.updateGramBoard(ounwanBoard) > 0) {
			return "success";
		} else {
			return "fail";
		}	
	}
	
	public int tagUpdate(int communityNumber, String[] hashTag) {
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("communityNumber", communityNumber);
		int result = 1;
		
		for(String name : communityDAO.hashTagsByNumber(communityNumber)) {
			dataMap.put("name", name);
			result *= communityDAO.removeTag(dataMap);
		}
		
		for(String name : hashTag) {
			dataMap.put("name", name);
			result *= communityDAO.insertHashTagName(name);
			result *= communityDAO.addHashTag(dataMap);
		}
		return result;
	}
	
	public List<OunwanGramDTO> searchByTag(String clientId, int rowNum, String name) {
		Map<String, Object> data = new HashMap<>();
		List<OunwanGramDTO> result = new ArrayList<>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);
		
		data.put("rowNum", rowNum);
		data.put("name", name);
		
		for(OunwanGram ounwangram : communityDAO.selectBoardsByTag(data)) {
			ounwangram.setLikesCheck(likeBoars.contains(ounwangram.getCommunityNumber()) ? 1 : 0);
			ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
			OunwanGramDTO ounwangramDTO = changeOunwanGram(ounwangram);
			if(ounwangramDTO.getClientId().equals(clientId)) {
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
		return new OunwanGramDTO().builder()
				.communityNumber(ounwangram.getCommunityNumber())
				.clientId(ounwangram.getClientId())
				.contents(ounwangram.getContents())
				.createdDate(ounwangram.getCreatedDate())
				.updatedDate(ounwangram.getUpdatedDate())
				.likes(ounwangram.getLikes())
				.imageUrl(ounwangram.getImageUrl())
				.profileUrl(ounwangram.getProfileUrl())
				.likesCheck(ounwangram.getLikesCheck())
				.hashTags(ounwangram.getHashTags())
				.build();
	}
	
	@SuppressWarnings("static-access")
	public OunwanGram changeOunwanGramEntity(OunwanGramDTO ounwangram) {
		return new OunwanGram().builder()
				.communityNumber(ounwangram.getCommunityNumber())
				.clientId(ounwangram.getClientId())
				.contents(ounwangram.getContents())
				.createdDate(ounwangram.getCreatedDate())
				.updatedDate(ounwangram.getUpdatedDate())
				.likes(ounwangram.getLikes())
				.imageUrl(ounwangram.getImageUrl())
				.profileUrl(ounwangram.getProfileUrl())
				.likesCheck(ounwangram.getLikesCheck())
				.hashTags(ounwangram.getHashTags())
				.build();
	}

}
