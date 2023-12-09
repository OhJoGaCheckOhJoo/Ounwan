package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

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
}