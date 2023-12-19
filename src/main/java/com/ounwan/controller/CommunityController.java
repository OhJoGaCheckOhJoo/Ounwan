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
import com.ounwan.dto.AetaLikesDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.PaginatingDTO;
import com.ounwan.service.CommunityService;


@RequestMapping("/community")
@Controller
public class CommunityController {
	
	@Autowired
	CommunityService communityService;
	
	
	//페이징 처리한 게시판
	@GetMapping("/aetaBoard")
	public String paginateBoard() {		
		return "community/aeta/aetaPaginatedBoard";
	}
	
	//애타 게시판 검색기능
	@GetMapping("/aetaSearch")
	public String aetaSearch(@RequestParam(value="inputValue",defaultValue="%") String inputValue,
			@RequestParam(value="selectedOption",defaultValue="%") String selectedOption,
			Model model,
			@RequestParam(value="page",required =false, defaultValue="1") 
	int page) {
		List<AetaDTO> aetaList = communityService.aetaList(page,inputValue,selectedOption);
		PaginatingDTO paginating= communityService.getPages(page,inputValue,selectedOption);
		
		System.out.println("aeat data: "+aetaList);
		System.out.println("aeta pageInfo"+paginating);
		System.out.println();
		
		model.addAttribute("aetaList", aetaList);
		model.addAttribute("paginating",paginating);
		
		model.addAttribute("inputValue",inputValue);
		model.addAttribute("selectedOption",selectedOption);
		
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
	public String aetaReadPost(@RequestParam String boardNumber,
			Model model, 
			HttpSession session) {
		
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
			
			AetaLikesDTO aetaLikesDTO=new AetaLikesDTO();
			aetaLikesDTO.setBoardNumber(Integer.parseInt(boardNumber));
			aetaLikesDTO.setClientId(logedInClient.getClientId());
			
			model.addAttribute("aetaPost", communityService.aetaReadPost(Integer.parseInt(boardNumber)));
			model.addAttribute("aetaCountLikes",communityService.aetaCountLikes(Integer.parseInt(boardNumber)));
			model.addAttribute("aetaLikesCheck",communityService.aetaLikesCheck(aetaLikesDTO));
			// 좋아요 개수 보내기
			// 확인
			
			System.out.println(model);
			System.out.println(model.getAttribute("aetaLikesCheck"));
			
			return "community/aeta/aetaPost";
			
		}
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
