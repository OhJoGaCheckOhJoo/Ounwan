package com.ounwan.controller;


import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.AetaCommentsDTO;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.AetaLikesDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.CommunityService;

@RequestMapping("/community")
@Controller
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
	
	
}









