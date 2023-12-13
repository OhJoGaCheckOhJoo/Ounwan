package com.ounwan.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.service.ClientsService;
import com.ounwan.service.CommunityService;

@Controller
public class CommunityController {
	
	@Autowired
	CommunityService communityService;
	
	@Autowired
	ClientsService clientsService;
	
	// 오늘운동했다그램 메인화면 요청
	@RequestMapping("/ounwangram")
	public String ounwangram(HttpSession session) {
		if(session.getAttribute("clientInfo") == null) {  	// 비로그인 > 로그인창
			return "login";
		} else {											// 로그인 > 오늘운동했다그램
			return "community/ounwangram";				
		}
	}
	
	// 오늘운동했다그램 글작성화면 요청
	@RequestMapping("/writeGramBoard")
	public String writeGramBoard() {
		return "community/writeOunwangram";
	}
	
	// 오늘운동했다그램 게시글 수정화면 요청
	@RequestMapping("/updateGramBoard")
	public String updateGramBoard(@RequestParam int communityNumber, Model model) {
		model.addAttribute("board", communityService.aGramBoard(communityNumber)); // 게시글 정보는 Model에 저장
		return "community/updateOunwangram";
	}
	
	@RequestMapping("/ounwanProfile")
	public String ounwanProfile(@RequestParam String clientId, Model model) {
		
		return "community/ounwangramProfile";
	}
}
