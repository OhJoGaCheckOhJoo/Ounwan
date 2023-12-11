package com.ounwan.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.OunwanGramDTO;
import com.ounwan.service.CommunityService;

@RestController
public class CommunityRestController {
	
	@Autowired
	CommunityService communityService;

	@RequestMapping("/ounwangram/followBoard")
	public List<OunwanGramDTO> ounwangramFollowBoard(@RequestParam int rowNum, HttpSession session) {
		return communityService.gramFollowBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), rowNum);
	}
	
	@RequestMapping("/ounwangram/wholeBoard")
	public List<OunwanGramDTO> ounwangramWholeBoard(@RequestParam int rowNum, HttpSession session) {
		return communityService.gramWholeBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), rowNum);
	}
	
	@RequestMapping("/ounwangram/likeBoard")
	public Map<String, Integer> ounwangramLikeBoard(@RequestParam int communityNumber, HttpSession session) {
		return communityService.gramLikeBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(), communityNumber);
	}
	
	@RequestMapping("/ounwangram/writeBoard")
	public String ounwanGramWriteBoard(HttpSession session, MultipartFile image, String content, String hashTag) throws IllegalStateException, IOException {
		communityService.gramWriteBoard(((ClientsDTO)session.getAttribute("clientInfo")).getClientId(),image, content, hashTag);
		return "123"; // 해시태그 처리하고나서 리턴 수정
	}
}