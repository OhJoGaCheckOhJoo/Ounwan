package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.OunwanGramDTO;
import com.ounwan.entity.OunwanGram;
import com.ounwan.repository.CommunityDAO;

@Service
public class CommunityService {
	
	@Autowired
	CommunityDAO communityDAO;

	public List<OunwanGramDTO> gramFollowBoard(String clientId, int rowNum) {
		Map<String, Object> dataMap = new HashMap<>();
		dataMap.put("clientId", clientId);
		dataMap.put("rowNum", rowNum);
		List<OunwanGramDTO> result = new ArrayList<>();
		for(OunwanGram ounwangram : communityDAO.gramFollowBoard(dataMap)) {
			result.add(changeOunwanGram(ounwangram));
		}
		return result;
	}

	public List<OunwanGramDTO> gramWholeBoard(int rowNum) {
		List<OunwanGramDTO> result = new ArrayList<>();
		for(OunwanGram ounwangram : communityDAO.gramWholeBoard(rowNum)) {
			result.add(changeOunwanGram(ounwangram));
		}
		System.out.println(result.toString());
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
				.build();
	}

}
