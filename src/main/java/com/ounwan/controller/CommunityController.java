package com.ounwan.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.dto.ClientsDTO;
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
	
	// 개인 프로필 요청
	@RequestMapping("/ounwanProfile")
	public String ounwanProfile(@RequestParam String clientId, HttpSession session, Model model) {
		model.addAttribute("userProfileInfo", communityService.getUserProfile(clientId, ((ClientsDTO)session.getAttribute("clientInfo")).getClientId()));
		model.addAttribute("userBoard", communityService.getUserBoards(clientId, ((ClientsDTO)session.getAttribute("clientInfo")).getClientId()));
		return "community/ounwangramProfile";
	}
	
	// 인바디 요청
	@RequestMapping("/inbody")
	public String showInbody(HttpSession session, Model model) {
		model.addAllAttributes(communityService.selectMyInbodyGraph(((ClientsDTO)session.getAttribute("clientInfo")).getClientId()));
		return "community/inbody";
	}
	
	// 인바디 입력 페이지 요청
	@RequestMapping("/inbodyInsert")
	public String insertInbodyPage(HttpSession session, Model model) {
		model.addAttribute("inbody", communityService.selectMyInbodyInfo(((ClientsDTO)session.getAttribute("clientInfo")).getClientId()));
		return "community/inbodyInsert";
	}
	
	// 팔로워 목록
	@RequestMapping("/followers")
	public String showFollowerList(@RequestParam String clientId, HttpSession session, Model model) {
		model.addAttribute("kind", "follower");
		model.addAttribute("profile", communityService.getProfile(clientId));
		model.addAttribute("followers", communityService.selectFollowerList(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), clientId));
		return "community/followList";
	}
	
	// 팔로잉 목록
	@RequestMapping("/following")
	public String showFollowingList(@RequestParam String clientId, HttpSession session, Model model) {
		model.addAttribute("kind", "following");
		model.addAttribute("profile", communityService.getProfile(clientId));
		model.addAttribute("followers", communityService.selectFollowingList(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), clientId));
		return "community/followList";
	}
	
	// 게시물디테일
	@RequestMapping("/gramDetail")
	public String selectOunwangramBoardDetail(@RequestParam int communityNumber, HttpSession session, Model model) {
		model.addAttribute("board", communityService.selectOunwangramBoardDetail(communityNumber, ((ClientsDTO)session.getAttribute("clientInfo")).getClientId()));
		return "community/ounwangramBoardDetail";
	}
}
