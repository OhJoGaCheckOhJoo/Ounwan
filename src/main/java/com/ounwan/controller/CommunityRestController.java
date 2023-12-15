package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.AetaCommentsDTO;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.AetaImagesDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.CommunityService;

@RequestMapping("/community")
@Controller
public class CommunityRestController {
	
	@Autowired
	CommunityService communityService;
	
	@GetMapping("/aetaSearch")
	public String aetaSearch(String inputValue,String selectedOption, Model model) {
		System.out.println("selected option:"+selectedOption);
		System.out.println("search word:"+inputValue);
		//서비스로 조건문 옮기
		
		List<AetaDTO> aetaList = communityService.aetaSearch(inputValue,selectedOption);
		model.addAttribute("aetaList", aetaList);
		return "community/aeta/aetaSearch";		
		//return aetaList; 레컨만들면 위에 두줄 지워주기
	}
	
	@PostMapping(value = "/aetaInsertComment", consumes="application/json")
	public @ResponseBody String aetaInsertComment(@RequestBody AetaCommentsDTO comment,
			HttpSession session) {
		System.out.println(session.getAttribute("userInfo"));
		ClientsDTO c= (ClientsDTO) session.getAttribute("userInfo");
		String id=c.getClientId();
		comment.setClient_id(id);
		
		boolean result = communityService.aetaInsertComment(comment);
		System.out.println("입력완료");
		return (result) ? "success" : "fail";
	}
	
	@PostMapping(value="/aetaPosting")
	public @ResponseBody String aetaInsertPost(@RequestBody AetaDTO obj,
			HttpSession session) {		
		int result=0;

		ClientsDTO user=(ClientsDTO)session.getAttribute("userInfo");
		obj.setClientId(user.getClientId());
		System.out.println("obj:"+obj);
		
		result=communityService.aetaInsertPost(obj);
		
		return (result>0)? "success":"fail";
	}
	
/*	@PostMapping(value="/aetaPosting")
	public @ResponseBody String aetaInsertPost(
			String title, String content,
			@RequestPart(value="image", required=false) MultipartFile image,
			HttpSession session) throws IllegalStateException {
		System.out.println(content);
		System.out.println(title);
		System.out.println(image);

		System.out.println("insertPost controller");
//		ClientsDTO user=(ClientsDTO)session.getAttribute("userInfo");
//		obj.setClientId(user.getClientId());
//		
//		
//		boolean result=communityService.aetaInsertPost(obj);
//		System.out.println("aeta uploaded");
//		Í
//		
		//return (result)?"sucess":"fail" ;
		return "success";
	}
*/
	@DeleteMapping(value="/aetaDeletePost")
	public @ResponseBody String aeteDeletePost(HttpSession session, 
			@RequestBody AetaDTO post
			) {
			ClientsDTO user=(ClientsDTO)session.getAttribute("userInfo");
			post.setClientId(user.getClientId());
			
			int result =communityService.aetaDeletePost(post);
		
			return (result>0)?"success":"fail";
	}
	
	@DeleteMapping(value="/aetaDeleteComment",consumes="application/json" )
	public @ResponseBody String aetaDeleteComment(@RequestBody AetaCommentsDTO comment,
			HttpSession session) {
		ClientsDTO c= (ClientsDTO) session.getAttribute("userInfo");
		comment.setClient_id(c.getClientId());
		
		boolean result =communityService.aetaDeleteComment(comment);
		return (result)?"success":"fail";
	}

}


