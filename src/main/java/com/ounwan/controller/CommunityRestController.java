package com.ounwan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.ounwan.dto.AetaDTO;
import com.ounwan.service.CommunityService;

@RequestMapping("/community")
@Controller
public class CommunityRestController {
	
	@Autowired
	CommunityService communityService;
	
	@GetMapping("/aetaSearch")
	public String aetaSearchAll(String input,String selectedValue, Model model) {
		System.out.println(selectedValue);
		System.out.println(input);
		
		List<AetaDTO> aetaList;
		if(selectedValue.equals("aetaSearchAll")) {
			aetaList =communityService.aetaSearchAll(input);
		}
		else if(selectedValue.equals("aetaSearchTitle")) {
			 aetaList =communityService.aetaSearchTitle(input);
		}
		else if(selectedValue.equals("aetaSearchId")) {
			aetaList =communityService.aetaSearchId(input);
		}else {
			aetaList =null;
			System.out.println("오류");
		}
			
		model.addAttribute("aetaList", aetaList);
		return "community/aeta/aetaSearch";		
	}
	
	
//	@GetMapping("/aetaSearchTitle")
//	public String aetaSearchTitle(String input, Model model) {
//		List<AetaDTO> aetaList = communityService.aetaSearchAll(input);
//		model.addAttribute("aetaList", aetaList);
//		return "community/aeta/aetaSearch";		
//	}
//	@GetMapping("/aetaSearchId")
//	public String aetaSearchId(String input, Model model) {
//		List<AetaDTO> aetaList = communityService.aetaSearchAll(input);
//		model.addAttribute("aetaList", aetaList);
//		return "community/aeta/aetaSearch";		
//	}
}


