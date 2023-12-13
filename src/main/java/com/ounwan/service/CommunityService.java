package com.ounwan.service;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
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

	public List<OunwanGramDTO> gramFollowBoard(String clientId, int rowNum) {
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("clientId", clientId);
		dataMap.put("rowNum", rowNum);
		List<OunwanGramDTO> result = new ArrayList<>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);
		for(OunwanGram ounwangram : communityDAO.gramFollowBoard(dataMap)) {
			ounwangram.setLikesCheck(likeBoars.contains(ounwangram.getCommunityNumber()) ? 1 : 0);
			ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
			result.add(changeOunwanGram(ounwangram));
		}
		return result;
	}

	public List<OunwanGramDTO> gramWholeBoard(String clientId, int rowNum) {
		List<OunwanGramDTO> result = new ArrayList<>();
		List<Integer> likeBoars = communityDAO.gramLikeBoards(clientId);
		for(OunwanGram ounwangram : communityDAO.gramWholeBoard(rowNum)) {
			ounwangram.setLikesCheck(likeBoars.contains(ounwangram.getCommunityNumber()) ? 1 : 0);
			ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
			result.add(changeOunwanGram(ounwangram));
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
			System.out.println("add : " + name);
			result *= communityDAO.insertHashTagName(name);
			result *= communityDAO.addHashTag(dataMap);
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
