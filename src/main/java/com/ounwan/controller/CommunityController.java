package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.PaginatingDTO;
import com.ounwan.service.CommunityService;


@RequestMapping("/community")
@Controller
public class CommunityController {
	
	@Autowired
	CommunityService communityService;
	
	//애타 게시판 조회
	/*
	@GetMapping("/aetaBoards")
	public String aeta(Model model) {
		System.out.println("aetaBoard");
		List<AetaDTO> aetaList = communityService.aetaBoardList();
		model.addAttribute("aetaList", aetaList);
		return "community/aeta/aetaBoard";
	}
	*/

	
	//페이징 처리한 게시판
	@GetMapping("/aetaPaginating")
	public String paging(Model model,
			@RequestParam(value="page",required =false, defaultValue="1") 
		int page) {
		//get board data
		List<AetaDTO> pagingList=communityService.aetaPaginating(page);
		System.out.println(pagingList);
		
		//get paging data
		PaginatingDTO paginating= communityService.paginatingParam(page);
		System.out.println(paginating);
		model.addAttribute("boardList",pagingList);
		model.addAttribute("paginating",paginating);
		return "community/aeta/aetaPaginatedBoard";
	}
	
	
	//애타 게시판 검색기능
	@GetMapping("/aetaSearch")
	public String aetaSearch(String inputValue,String selectedOption, Model model,
			@RequestParam(value="page",required =false, defaultValue="1") int page) {
		
		List<AetaDTO> aetaList = communityService.aetaSearch(inputValue,selectedOption);

		//PaginatingDTO paginating= communityService.paginatingSearchAll(page,inputValue);
		//System.out.println(paginating);
		model.addAttribute("aetaList", aetaList);
		//model.addAttribute("paginating",paginating);
		
		return "community/aeta/aetaSearch";	
	}
	
	//애타 게시판 등록페이지 이동
	@GetMapping("/aetaPosting")
	public String aetaPostingPage(Model model,HttpSession session) {
		if(session.getAttribute("userInfo")==null) {
			System.out.println("off to loginPage");
			return "login";
		}
		return	"community/aeta/aetaPosting";	
	}
	
	//애타 게시글 조회
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
	
	//게시글 수정 페이지 조회 (모달로 해주기)
	@GetMapping("/aetaUpdatePost")
	public String aetaUpdatePage(Model model,HttpSession session,
			AetaDTO post
			){
		System.out.println(post.getBoardNumber());
		System.out.println(post.getTitle());
		System.out.println(post.getContents());
		
		
		return "community/aeta/aetaUpdatePage";
	}

}
