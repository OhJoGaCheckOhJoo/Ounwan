package com.ounwan.service;

import java.sql.Date;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.AetaCommentsDTO;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.AetaImagesDTO;
import com.ounwan.entity.AetaBoards;
import com.ounwan.entity.AetaImages;
import com.ounwan.entity.Comments;
import com.ounwan.repository.CommunityDAO;

@Service
public class CommunityService {

	@Autowired
	CommunityDAO communityDAO;

	public List<AetaDTO> aetaBoardList() {
		return changeDTOList(communityDAO.aetaBoardList());
	}

	public List<AetaDTO> aetaSearch(String inputValue, String selectedOption) {

		if (selectedOption.equals("aetaSearchAll"))
			return changeDTOList(communityDAO.aetaSearchAll(inputValue));
		if (selectedOption.equals("aetaSearchTitle"))
			return changeDTOList(communityDAO.aetaSearchTitle(inputValue));
		if (selectedOption.equals("aetaSearchId"))
			return changeDTOList(communityDAO.aetaSearchId(inputValue));
		System.out.println("오류");
		return null;

	}

	public List<Map<String, Object>> aetaReadPost(int boardNumber) {

		return communityDAO.aetaReadPost(boardNumber);
	}

	public boolean aetaUpdateViews(int boardNumber) {
		int result = communityDAO.aetaUpdateViews(boardNumber);
		return (result > 0) ? true : false;
	}

	public int aetaInsertPost(AetaDTO post) {
		System.out.println("insertPost service");
		AetaBoards board = changeEntity(post);
		int result = communityDAO.aetaInsertPost(board);		
		System.out.println("추가된 게시글번호:"+post.getBoardNumber());
//		if (result > 0) {
//			images.setBoardNumber(post.getBoardNumber());
//			System.out.println("boardNum:" + images.getBoardNumber());
//			result=communityDAO.aetaInsertImageURL(changeEntity(images));
//		}

		return result;
	}
	public int aetaDeletePost(AetaDTO post) {
		int result=communityDAO.aetaDeletePost(post.getBoardNumber());
		return result;
	}

	public boolean aetaInsertComment(AetaCommentsDTO comment) {
		int result = communityDAO.aetaInsertComment(changeEntity(comment));
		return (result > 0) ? true : false;
	}

	public boolean aetaDeleteComment(AetaCommentsDTO comment) {
		Comments c = changeEntity(comment);
		System.out.println("boardNum: " + c.getBoardNumber());

		int result = communityDAO.aetaDeleteComment(comment.getCommentNumber());
		System.out.println(comment);
		System.out.println(changeEntity(comment));

		return (result > 0) ? true : false;
	}

	public AetaImages changeEntity(AetaImagesDTO images) {
		return AetaImages.builder()
				.imageUrl(images.getImageUrl())
				.boardNumber(images.getBoardNumber())
				.build();
	}

	public Comments changeEntity(AetaCommentsDTO comment) {
		return Comments.builder().clientId(comment.getClient_id()).commentNumber(comment.getCommentNumber())
				.boardNumber(comment.getBoardNumber()).contents(comment.getContents())
				.createdDate(comment.getCreatedDate()).updatedDate(comment.getUpdatedDate()).likes(comment.getLikes())
				.build();
	}

	public List<AetaDTO> changeDTOList(List<AetaBoards> boardList) {
		List<AetaDTO> list = new ArrayList<AetaDTO>();
		for (AetaBoards aeta : boardList) {
			list.add(changeDTO(aeta));
		}
		return list;

	}

	public AetaDTO changeDTO(AetaBoards aeta) {
		return AetaDTO.builder().boardNumber(aeta.getBoardNumber()).title(aeta.getTitle()).contents(aeta.getContents())
				.clientId(aeta.getClientId()).createdDate(aeta.getCreatedDate()).updatedDate(aeta.getCreatedDate())
				.views(aeta.getViews()).likes(aeta.getLikes()).build();
	}

	public AetaBoards changeEntity(AetaDTO aeta) {
		return AetaBoards.builder().boardNumber(aeta.getBoardNumber()).title(aeta.getTitle())
				.contents(aeta.getContents()).clientId(aeta.getClientId()).createdDate(aeta.getCreatedDate())
				.updatedDate(aeta.getCreatedDate()).views(aeta.getViews()).likes(aeta.getLikes()).build();
	}



}
