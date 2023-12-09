package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.AetaDTO;
import com.ounwan.entity.AetaBoards;
import com.ounwan.repository.CommunityDAO;

@Service
public class CommunityService {

	@Autowired 
	CommunityDAO communityDAO;
	
	public List<AetaDTO> aetaBoardList() {
		return changeDTOList(communityDAO.aetaBoardList());
	}
	public List<AetaDTO> aetaSearchAll(String searchWord){
		return changeDTOList(communityDAO.aetaSearchAll(searchWord));
	}
	public List<AetaDTO> aetaSearchTitle(String searchWord){
		return changeDTOList(communityDAO.aetaSearchTitle(searchWord));
	}
	public List<AetaDTO> aetaSearchId(String searchWord){
		return changeDTOList(communityDAO.aetaSearchId(searchWord));
	}

	
	public AetaBoards changeEntity(AetaDTO aeta) {
        return AetaBoards.builder()
                .boardNumber(aeta.getBoardNumber())
                .title(aeta.getTitle())
                .contents(aeta.getContents())
                .clientId(aeta.getClientId())
                .createdDate(aeta.getCreatedDate())
                .updatedDate(aeta.getCreatedDate())
                .views(aeta.getViews())
                .likes(aeta.getLikes())
                .build();
        
    }
	
	public List<AetaDTO> changeDTOList(List<AetaBoards> boardList){
		List<AetaDTO> list = new ArrayList<AetaDTO>();
		for(AetaBoards aeta:boardList) {
			list.add(changeDTO(aeta));
		}
		return list;
		
	}
	
    public AetaDTO changeDTO(AetaBoards aeta) {
    	return AetaDTO.builder()
    			.boardNumber(aeta.getBoardNumber())
                .title(aeta.getTitle())
                .contents(aeta.getContents())
                .clientId(aeta.getClientId())
                .createdDate(aeta.getCreatedDate())
                .updatedDate(aeta.getCreatedDate())
                .views(aeta.getViews())
                .likes(aeta.getLikes())
    			.build();
    			
    }
}
