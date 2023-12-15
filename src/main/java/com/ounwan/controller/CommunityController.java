package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.CommunityService;


@RequestMapping("/community")
@Controller
public class CommunityController {
	
	@Autowired
	CommunityService communityService;
	
	@GetMapping("/aetaBoards")
	public String aeta(Model model) {
		System.out.println("aetaBoard");
		List<AetaDTO> aetaList = communityService.aetaBoardList();
		model.addAttribute("aetaList", aetaList);
		return "community/aeta/aetaBoard";
	}
	
	@GetMapping("/aetaPosting")
	public String aetaPostingPage(Model model,HttpSession session) {
		if(session.getAttribute("userInfo")==null) {
			System.out.println("off to loginPage");
			return "login";
		}
		return	"community/aeta/aetaPosting";	
	}
	
	@GetMapping("/aetaPost")
	public String aetaReadPost(@RequestParam String boardNumber,Model model, HttpSession session) {
		System.out.println("ReadPost(controller)");
		
		if(session.getAttribute("userInfo")==null) {
			System.out.println("off to loginPage");
			model.addAttribute("loginRequired", true);
			//모달?
			return "common/loginModal";
		}else {
			
			ClientsDTO logedInClient = (ClientsDTO) session.getAttribute("userInfo");
			session.setAttribute("clientId", logedInClient.getClientId());
			
			boolean updateView=communityService.aetaUpdateViews(Integer.parseInt(boardNumber)); //조회수 +1
			if (updateView) {
				System.out.println("updated views (+1)");
			}else {
				System.out.println("failed to update views");
			}
			
			model.addAttribute("aetaPost", communityService.aetaReadPost(Integer.parseInt(boardNumber)));
		}
		return "community/aeta/aetaPost";
	}
	
}
