package com.ounwan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ounwan.dto.AetaDTO;
import com.ounwan.service.CommunityService;


@RequestMapping("/community")
@Controller
public class CommunityController {
	
	@Autowired
	CommunityService communityService;
	
	@RequestMapping("/aetaBoards")
	public String aeta(Model model) {
		System.out.println("게시판 ");
		List<AetaDTO> aetaList = communityService.aetaBoardList();
		model.addAttribute("aetaList", aetaList);
		return "community/aeta/aetaBoard";
	}	
	
		
	
	
}
