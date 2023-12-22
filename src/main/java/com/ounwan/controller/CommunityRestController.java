package com.ounwan.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.InbodyDTO;
import com.ounwan.dto.OunwanGramDTO;
import com.ounwan.service.CommunityService;
import com.ounwan.dto.AetaCommentsDTO;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.AetaLikesDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.CommunityService;

@RequestMapping("/community")
@RestController
public class CommunityRestController {
	
	@Autowired
	CommunityService communityService;
	
	//게시글 등록(사진제외)
	@PostMapping(value="/aetaPosting")
	public	String aetaInsertPost(
			//@RequestParam("title")String title,
			String title,
			String contents,
			@RequestParam(required=false)String imageUrl1,
			@RequestParam(required=false)String imageUrl2,
			@RequestParam(required=false)String imageUrl3,
			HttpSession session
			) {		
		System.out.println(imageUrl1);
		System.out.println(imageUrl2);
		System.out.println(imageUrl3);
		int result=0;

		ClientsDTO user=(ClientsDTO)session.getAttribute("userInfo");
		String clientId=(user.getClientId());
		result=communityService.aetaInsertPost(clientId,title,contents,imageUrl1,imageUrl2,imageUrl3);
		
		return (result>0)? "success":"fail";
	}
	
	
	//게시글 수정 기능
//	@PutMapping(value="/aetaUpdatePost")
//	public @ResponseBody String aetaUpdatePost(HttpSession session 
//			) {
//		int result =0;
//
//		
//		ClientsDTO user=(ClientsDTO)session.getAttribute("userInfo");
////		if(user.getClientId()==communityService.findClientId(aetaPost.getBoardNumber())) {
////			result = communityService.aetaUpdatePost(aetaPost, aetaImages);
////		}else {
////			System.out.println("수정 컨트롤러 수정 오류");
////		}
//		
//		return (result>0)?"success":"fail";
//	}
	
	//게시글 삭제 기능
	@DeleteMapping(value="/aetaDeletePost")
	public @ResponseBody String aeteDeletePost(HttpSession session, 
			@RequestBody AetaDTO post
			) {
			ClientsDTO user=(ClientsDTO)session.getAttribute("userInfo");
			post.setClientId(user.getClientId());
			
			int result =communityService.aetaDeletePost(post);
		
			return (result>0)?"success":"fail";
	}

	//좋아요 버튼 기능
		@PostMapping(value="/likeButton")
		public @ResponseBody AetaLikesDTO aetaLike(String boardNumber,
				HttpSession session) {
			System.out.println("likebuttoncontroller");
			ClientsDTO user=(ClientsDTO)session.getAttribute("userInfo");

			return communityService.aetaLikesButton(Integer.parseInt(boardNumber),user);
		}
	// 게시글 댓글 등록
	@PostMapping(value = "/aetaInsertComment", consumes = "application/json")
	public @ResponseBody String aetaInsertComment(@RequestBody AetaCommentsDTO comment, HttpSession session) {
		System.out.println(session.getAttribute("userInfo"));
		ClientsDTO c = (ClientsDTO) session.getAttribute("userInfo");
		String id = c.getClientId();
		comment.setClient_id(id);

		boolean result = communityService.aetaInsertComment(comment);
		System.out.println("입력완료");
		return (result) ? "success" : "fail";
	}

	// 댓글 삭제 기능
	@DeleteMapping(value = "/aetaDeleteComment", consumes = "application/json")
	public @ResponseBody String aetaDeleteComment(@RequestBody AetaCommentsDTO comment, HttpSession session) {
		ClientsDTO c = (ClientsDTO) session.getAttribute("userInfo");
		comment.setClient_id(c.getClientId());
		System.out.println(comment);
		boolean result = communityService.aetaDeleteComment(comment);
		return (result) ? "success" : "fail";
	}

	// 친구보기 요청
	@RequestMapping("/ounwangram/followBoard")
	public List<OunwanGramDTO> ounwangramFollowBoard(@RequestParam int rowNum, HttpSession session) {
		return communityService.gramFollowBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), rowNum);
	}
	
	// 전체보기 요청
	@RequestMapping("/ounwangram/wholeBoard")
	public List<OunwanGramDTO> ounwangramWholeBoard(@RequestParam int rowNum, HttpSession session) {
		return communityService.gramWholeBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), rowNum);
	}
	
	// 게시글 좋아요
	@RequestMapping("/ounwangram/likeBoard")
	public Map<String, Integer> ounwangramLikeBoard(@RequestParam int communityNumber, HttpSession session) {
		return communityService.gramLikeBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), communityNumber);
	}
	
	// 게시글 작성
	@RequestMapping("/ounwangram/writeBoard")
	public String ounwanGramWriteBoard(HttpSession session, MultipartFile image, String content, String[] hashTag) throws IllegalStateException, IOException {
		return communityService.gramWriteBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), image, content, hashTag);
	}
	
	// 게시글 수정
	@RequestMapping("/ounwangram/updateBoard")
	public String ounwanGramUpdateBoard(HttpSession session, int communityNumber, MultipartFile image, String content, String[] hashTag) throws IllegalStateException, IOException {
		return communityService.gramUpdateBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), communityNumber, image, content, hashTag);
	}
	
	// 게시글 삭제
	@RequestMapping("/ounwangram/deleteBoard")
	public String ounwangramDeleteBoard(int communityNumber) {
		return communityService.deleteGramBoard(communityNumber);
	}
	
	// 오늘운동했다그램 메인 검색
	@RequestMapping("/ounwangram/ajaxSearch")
	public List<Map<String, Object>> ounwangramAjaxSearch(String keyword) {
		return communityService.searchAjaxGram(keyword);
	}
	
	// 오늘운동했다그램 태그 검색
	@RequestMapping("/ounwangram/tagBoard")
	public List<OunwanGramDTO> ounwangramTagBoard(@RequestParam int rowNum, @RequestParam String name, HttpSession session) {	
		return communityService.searchByTag(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), rowNum, name);
	}
	
	// 오늘운동했다그램 신고
	@RequestMapping("/ounwangram/reportBoard")
	public String ounwangramReportBoard(@RequestParam int communityNumber, @RequestParam int[] reason, HttpSession session) {
		return communityService.reportBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), communityNumber, reason);
	}
	
	// 인바디 입력 요청
	@RequestMapping("/insertInbody")
	public Map<String, Object> insertInbody(InbodyDTO inbody, HttpSession session, Model model) {
		return communityService.insertInbody(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), inbody);
	}
	
	// 인바디 수정 요청
	@RequestMapping("/updateInbody")
	public Map<String, Object> updateInbody(InbodyDTO inbody, HttpSession session, Model model) {
		return communityService.updateInbody(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), inbody);
	}
	
	// 팔로우 확인
	@RequestMapping("/checkFollowing")
	public int checkFollowing(@RequestParam String clientId, HttpSession session) {
		return communityService.checkFollowing(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), clientId);
	}
	
	// 팔로우 취소
	@RequestMapping("/cancelFollowing")
	public int cancelFollowing(@RequestParam String clientId, HttpSession session) {
		return communityService.cancelFollowing(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), clientId);
	}
	
	// 팔로우 요청
	@RequestMapping("/addFollowing")
	public int addFollowing(@RequestParam String clientId, HttpSession session) {
		return communityService.addFollowing(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), clientId);
	}
}
