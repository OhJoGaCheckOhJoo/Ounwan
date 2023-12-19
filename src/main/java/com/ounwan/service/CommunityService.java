package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.AetaCommentsDTO;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.AetaImagesDTO;
import com.ounwan.dto.AetaLikesDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.PaginatingDTO;
import com.ounwan.entity.Aeta;
import com.ounwan.entity.AetaImages;
import com.ounwan.entity.AetaLikes;
import com.ounwan.entity.Comments;
import com.ounwan.repository.CommunityDAO;

@Service
public class CommunityService {

	@Autowired
	CommunityDAO communityDAO;

	int pageLimit = 10; // the number of posts to show on a page
	int blockLimit = 10; // the number of paginated number on the bottom

	// 페이징 된 게시판 조회
	// 게시판 검색 기능
	public List<AetaDTO> aetaList(int page, String inputValue, String selectedOption) {

		int pageStartNum = (page - 1) * pageLimit;

		Map<String, Object> paginateParams = new HashMap<>();

		paginateParams.put("start", pageStartNum);
		paginateParams.put("limit", pageLimit);
		paginateParams.put("inputValue", inputValue);

		if (selectedOption.equals("aetaSearchAll"))
			return changeDTOList(communityDAO.aetaSearchAll(paginateParams));
		if (selectedOption.equals("aetaSearchTitle"))
			return changeDTOList(communityDAO.aetaSearchTitle(paginateParams));
		if (selectedOption.equals("aetaSearchId"))
			return changeDTOList(communityDAO.aetaSearchId(paginateParams));
		return communityDAO.AetaList(paginateParams); // 애게시판메인
	}

	// 페이징 구현
	public PaginatingDTO paginatingParam(int page) {

		// 전체 게시글 갯수
		int CountAllPosts = communityDAO.CountAllPosts();
		// 전체 페이지 갯수
		int maxPageNumber = (int) (Math.ceil((double) CountAllPosts / pageLimit));
		// 시작할 페이지 값 계산
		int startPageNumber = (((int) (Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
		// 끝 페이지 값 계산
		int endPageNumber = startPageNumber + blockLimit - 1;
		if (endPageNumber > maxPageNumber) {
			endPageNumber = maxPageNumber;
		}
		return PaginatingDTO.builder().pageNumber(page).maxPageNumber(maxPageNumber).startPageNumber(startPageNumber)
				.endPageNumber(endPageNumber).build();
	}

	// 하단 페이징한 데이터
	public PaginatingDTO getPages(int page, String inputValue, String selectedOption) {
		int countPosts = 0;
		// 출력할 게시글 갯수
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

		// 전체 페이지 갯수
		int maxPageNumber = (int) (Math.ceil((double) countPosts / pageLimit));
		// 시작할 페이지 값 계산
		int startPageNumber = (((int) (Math.ceil((double) page / blockLimit))) - 1) * blockLimit + 1;
		// 끝 페이지 값 계산
		int endPageNumber = startPageNumber + blockLimit - 1;
		if (endPageNumber > maxPageNumber) {
			endPageNumber = maxPageNumber;
		}

		return PaginatingDTO.builder().pageNumber(page).maxPageNumber(maxPageNumber).startPageNumber(startPageNumber)
				.endPageNumber(endPageNumber).build();
	}

	// 게시글 등록
	public int aetaInsertPost(AetaDTO post) {
		System.out.println("insertPost service");
		Aeta board = changeEntity(post);
		int result = communityDAO.aetaInsertPost(board);

		// 에러
		System.out.println("추가된 게시글번호:" + post.getBoardNumber());
//		if (result > 0) {
//			images.setBoardNumber(post.getBoardNumber());
//			System.out.println("boardNum:" + images.getBoardNumber());
//			result=communityDAO.aetaInsertImageURL(changeEntity(images));
//		}

		return result;
	}

	// 게시글 조회
	public List<Map<String, Object>> aetaReadPost(int boardNumber) {
		return communityDAO.aetaReadPost(boardNumber);
	}

	// 게시글 조회수 증가 기능
	public boolean aetaUpdateViews(int boardNumber) {
		return (communityDAO.aetaUpdateViews(boardNumber) > 0) ? true : false;
	}

	// 게시글 좋아요 기능
	public int aetaCountLikes(int boardNumber) {
		return communityDAO.aetaCountLikes(boardNumber);
	}

	public int aetaLikesCheck(AetaLikesDTO aetaLikesDTO) {
		return communityDAO.aetaLikesCheck(changeEntity(aetaLikesDTO));
	}

	//좋아요 버튼 기능
	public AetaLikesDTO aetaLikesButton(int boardNumber,ClientsDTO user) {		
		AetaLikesDTO data= AetaLikesDTO
				.builder()
				.boardNumber(boardNumber)
				.clientId(user.getClientId())
				.build();
		
		int checkLikes = communityDAO.aetaLikesCheck(changeEntity(data));
		Boolean like = null;
		Boolean dislike = null;
		System.out.println("checklikes:"+checkLikes);
		if (checkLikes == 0) {
			like = (communityDAO.aetaLike(changeEntity(data)) > 0) ? true : false;
			
		} else {
			dislike = (communityDAO.aetaDislike(changeEntity(data)) > 0) ? true : false;
		}
		int count = communityDAO.aetaCountLikes(boardNumber);
		return AetaLikesDTO.builder().like(like).dislike(dislike).likesCount(count).build();
	}


	// 게시글 수정
	public int aetaUpdatePost(AetaDTO post) {
		int result = communityDAO.aetaUpdatePost(changeEntity(post));
		return result;
	}

	// 게시글 삭제
	public int aetaDeletePost(AetaDTO post) {
		int result = communityDAO.aetaDeletePost(post.getBoardNumber());
		return result;
	}

	// 댓글 등록
	public boolean aetaInsertComment(AetaCommentsDTO comment) {
		return (communityDAO.aetaInsertComment(changeEntity(comment)) > 0) ? true : false;
	}

	// 댓글 삭제
	public boolean aetaDeleteComment(AetaCommentsDTO comment) {
		Comments c = changeEntity(comment);
		System.out.println("boardNum: " + c.getBoardNumber());

		return (communityDAO.aetaDeleteComment(comment.getCommentNumber()) > 0) ? true : false;
	}

	/* DTO와 Entity 타입바꿔주는 함수들 */
	private Aeta changeEntity(AetaDTO aeta) {
		return Aeta.builder().boardNumber(aeta.getBoardNumber()).title(aeta.getTitle()).contents(aeta.getContents())
				.clientId(aeta.getClientId()).createdDate(aeta.getCreatedDate()).updatedDate(aeta.getCreatedDate())
				.views(aeta.getViews()).likes(aeta.getLikes()).build();
	}

	private AetaImages changeEntity(AetaImagesDTO images) {
		return AetaImages.builder().imageUrl(images.getImageUrl()).boardNumber(images.getBoardNumber()).build();
	}

	private Comments changeEntity(AetaCommentsDTO comment) {
		return Comments.builder().clientId(comment.getClient_id()).commentNumber(comment.getCommentNumber())
				.boardNumber(comment.getBoardNumber()).contents(comment.getContents())
				.createdDate(comment.getCreatedDate()).updatedDate(comment.getUpdatedDate()).likes(comment.getLikes())
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
		return AetaDTO.builder().boardNumber(aeta.getBoardNumber()).title(aeta.getTitle()).contents(aeta.getContents())
				.clientId(aeta.getClientId()).createdDate(aeta.getCreatedDate()).updatedDate(aeta.getCreatedDate())
				.views(aeta.getViews()).likes(aeta.getLikes()).build();
	}

	private AetaLikes changeEntity(AetaLikesDTO aetaLikesDTO) {
		return AetaLikes.builder().likeNumber(aetaLikesDTO.getLikeNumber()).boardNumber(aetaLikesDTO.getBoardNumber())
				.clientId(aetaLikesDTO.getClientId()).build();
	}
//	private AetaLikesDTO changeAetaLikesDTO(int boardNumber, ClientsDTO user) {
//		return AetaLikesDTO
//		.builder()
//		.boardNumber(boardNumber)
//		.clientId(user.getClientId())
//		.build();
//	}

}
