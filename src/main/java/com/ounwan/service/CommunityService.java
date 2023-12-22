package com.ounwan.service;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

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
import com.ounwan.dto.InbodyDTO;
import com.ounwan.dto.OunwanGramDTO;
import com.ounwan.entity.Inbody;
import com.ounwan.entity.OunwanGram;
import com.ounwan.entity.OunwanGramLikes;
import com.ounwan.repository.CommunityDAO;

@Service
public class CommunityService {
	
	@Autowired
	CommunityDAO communityDAO;
	
	private final static String UPLOADPATH = "C:/shinhan/sts-workspace/ounwan/src/main/webapp/resources";
	private final static String IMAGEPATH = "/images/uploads/";
	
	public OunwanGramDTO selectOunwangramBoardDetail(int communityNumber, String clientId) {
		Map<String, Object> data = new HashMap<>();
		data.put("communityNumber", communityNumber);
		data.put("clientId", clientId);
		OunwanGramDTO ounwangram = changeOunwanGram(communityDAO.selectOunwangramBoardDetail(data));
		ounwangram.setHashTags(communityDAO.hashTagsByNumber(ounwangram.getCommunityNumber()));
		System.out.println(ounwangram.toString());
		return ounwangram;
	}
	
	public int addFollowing(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<>();
		data.put("relationId", profileId + "-" + clientId);
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.addFollowing(data);
	}
	
	public int cancelFollowing(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<>();
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.cancelFollowing(data);
	}
	
	public int checkFollowing(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<>();
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.checkFollow(data);
	}
	
	public Map<String, Object> getProfile(String profileId) {
		Map<String, Object> result = new HashMap<>();
		result.put("image", communityDAO.getProfileImage(profileId));
		result.put("clientId", profileId);
		return result;
	}
	
	public Map<String, Object> updateInbody(String clientId, InbodyDTO inbody) {
		inbody.setClientId(clientId);
		Map<String, Object> result = new HashMap<>();
		result.put("clientId", clientId);
		if(communityDAO.updateInbody(changeInbodyEntity(inbody)) > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	public Map<String, Object> insertInbody(String clientId, InbodyDTO inbody) {
		inbody.setClientId(clientId);
		Map<String, Object> result = new HashMap<>();
		result.put("clientId", clientId);
		if(communityDAO.insertInbody(changeInbodyEntity(inbody)) > 0) {
			result.put("result", "success");
		} else {
			result.put("result", "fail");
		}
		return result;
	}
	
	public List<Map<String, Object>> selectFollowerList(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<>();
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.selectFollowerList(data);
	}
	
	public List<Map<String, Object>> selectFollowingList(String clientId, String profileId) {
		Map<String, Object> data = new HashMap<>();
		data.put("clientId", clientId);
		data.put("profileId", profileId);
		return communityDAO.selectFollowingList(data);
	}
	
	public List<InbodyDTO> selectMyInbodyInfo(String clientId) {
		List<InbodyDTO> result = new ArrayList<>();
		for(Inbody inbody : communityDAO.selectMyInbody(clientId)) {
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
		
		for(Inbody inbody : communityDAO.selectMyInbody(clientId)) {
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
		return OunwanGramDTO.builder()
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
		return OunwanGram.builder()
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
	
	public InbodyDTO changeInbody(Inbody inbody) {
		return InbodyDTO.builder()
				.inbodyNumber(inbody.getInbodyNumber())
				.clientId(inbody.getClientId())
				.height(inbody.getHeight())
				.weight(inbody.getWeight())
				.skeletalMusclesMass(inbody.getSkeletalMusclesMass())
				.bodyWater(inbody.getBodyWater())
				.bmr(inbody.getBmr())
				.bmi(inbody.getBmi())
				.inbodyScore(inbody.getInbodyScore())
				.updatedDate(inbody.getUpdatedDate())
				.build();
	}
	
	public Inbody changeInbodyEntity(InbodyDTO inbody) {
		return Inbody.builder()
				.inbodyNumber(inbody.getInbodyNumber())
				.clientId(inbody.getClientId())
				.height(inbody.getHeight())
				.weight(inbody.getWeight())
				.skeletalMusclesMass(inbody.getSkeletalMusclesMass())
				.bodyWater(inbody.getBodyWater())
				.bmr(inbody.getBmr())
				.bmi(inbody.getBmi())
				.inbodyScore(inbody.getInbodyScore())
				.updatedDate(inbody.getUpdatedDate())
				.build();
	}

	@Autowired
	CommunityDAO communityDAO;
	
	//이미지 저장 경로 지정
	public static final String AETA_IMAGE_REPO="/Users/jungwoo/Desktop/importance/photo";
	
	//이미지 저장 메소드
	public String saveFile(MultipartFile file) {
		SimpleDateFormat aetaDateFormat=new SimpleDateFormat("yyyyMMddHHmmss-"); //날짜 형태로 저장
		Calendar calendar = Calendar.getInstance();
		
		String aetaFileName =
				aetaDateFormat.format(calendar.getTime())+file.getOriginalFilename();
		
		File aetaSaveFile = new File(AETA_IMAGE_REPO+"/"+aetaFileName);
		
		try {
			file.transferTo(aetaSaveFile);
		}catch (Exception e) {
			e.printStackTrace();
		}
		return aetaFileName;
		
	}
	

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
		return communityDAO.AetaList(paginateParams); // 애타 게시판메인
	}

	//페이징 구현
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
	public int aetaInsertPost(String clientId,String title,String contents,String imageUrl1,String imageUrl2,String imageUrl3) {
		
		int imageResult=0;
		List<String> urlList = List.of(imageUrl1,imageUrl2,imageUrl3);	
		int postResult=communityDAO.aetaInsertPost(changeEntity(AetaDTO
				.builder()
				.clientId(clientId)
				.title(title)
				.contents(contents)
				.build()));
		if(urlList!=null) {
			for(int i=0;i<urlList.size() ;i++) {
				System.out.println("imageurl "+i+":"+urlList.indexOf(i));
				imageResult=imageResult=communityDAO.aetaInsertImageURL(urlList.get(i));
			}
		}else {
			//image null이면 참
			imageResult=1;
		}
		
		int result=0;
		if(imageResult==1&&postResult==1)result=1;

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

	public int aetaLikesCheck(int boardNumber,String clientId) {
		return communityDAO.aetaLikesCheck(changeEntity(AetaLikesDTO
				.builder()
				.boardNumber(boardNumber)
				.clientId(clientId)
				.build()));
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


	// 게시글 수정페이지에 보여줄 데이터
	public List<Map<String, Object>> aetaPostToBeUpdated(int boardNumber){
		return communityDAO.aetaPostToBeUpdated(boardNumber);
	}
	
	// 게시글 수정 //title,contents,boardNumber | imageUrl,boardNumber
	public int aetaUpdatePost(AetaDTO post, AetaImagesDTO images) {
		int result=0;
		int postResult = communityDAO.aetaUpdatePost(changeEntity(post));
		int imageResult = communityDAO.aetaUpdatePostURL(changeEntity(images));
		
		if(postResult==1 && imageResult==1) {
			result=1;
		}
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

		return (communityDAO.aetaDeleteComment(changeEntity(comment)) > 0) ? true : false;
		
	}

	
	

	//게시글 번호(BOARD_NUMBER)로 작성자(CLIENT_ID) 아이디 가져오기 
	public String findClientId(int boardNumber) {
		return communityDAO.findClientId(boardNumber);
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
				.createdDate(comment.getCreatedDate()).updatedDate(comment.getUpdatedDate())
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

}
