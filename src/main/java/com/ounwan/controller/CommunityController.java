package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.AetaLikesDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.PaginatingDTO;
import com.ounwan.service.CommunityService;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.ClientsService;
import com.ounwan.service.CommunityService;


@RequestMapping("/community")
@Controller
public class CommunityController {
	
	@Autowired
	CommunityService communityService;
	
	@Autowired
	ClientsService clientsService;
	
	
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
			@RequestParam(value="page",required =false, defaultValue="1") int page) {
		
		List<AetaDTO> aetaList = communityService.aetaList(page,inputValue,selectedOption);
		PaginatingDTO paginating= communityService.getPages(page,inputValue,selectedOption);
		
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
	public String aetaReadPost(@RequestParam String aetaNumber,
			Model model, 
			HttpSession session) {
		
		if(session.getAttribute("userInfo")==null) {
			System.out.println("off to loginPage");
			model.addAttribute("loginRequired", true);
			//모달 만들어주기
			return "login";
			
		}else {
			
			ClientsDTO logedInClient = (ClientsDTO) session.getAttribute("userInfo");
			//세션에 client id 저장
			session.setAttribute("clientId", logedInClient.getClientId());
			boolean updateView=communityService.aetaUpdateViews(Integer.parseInt(aetaNumber)); //조회수 +1
			if (!updateView) {
				System.out.println("failed to update views");
			}
			
			//게시글 데이터 전송
			model.addAttribute("aetaPost", communityService.aetaReadPost(Integer.parseInt(aetaNumber)));
			//좋아요 갯수
			model.addAttribute("aetaCountLikes",communityService.aetaCountLikes(Integer.parseInt(aetaNumber)));
			//게시글 댓글 데이터 전송
			model.addAttribute("aetaComments",communityService.aetaReadComments(Integer.parseInt(aetaNumber)));
			System.out.println("\n\n\naetaReadPost controller, model댓글추가:"+model);
			//댓글 갯수
			model.addAttribute("aetaCountComments",communityService.aetaCountComments(Integer.parseInt(aetaNumber)));
			
			//접속자 좋아요 체크 여부
			model.addAttribute("aetaLikesCheck",communityService.aetaLikesCheck(Integer.parseInt(aetaNumber),logedInClient.getClientId()));
//			System.out.println(model);

			return "community/aeta/aetaPost";
		}
	}
	//애타 게시글 수정 페이지
	@GetMapping("/aetaUpdating")
	public String aetaUpdatePage(
			HttpSession session,
			Model model,
			//@RequestParam String aetaCountImages,
			@RequestParam String aetaNumber
			){
			
			//model.addAttribute("aetaCountImages", aetaCountImages);
			model.addAttribute("aetaPost",communityService.aetaPostToBeUpdated(Integer.parseInt(aetaNumber)));
		return "community/aeta/aetaUpdating";
	}
	
	// 오늘운동했다그램 메인화면 요청
	@RequestMapping("/ounwangram")
	public String ounwangram(HttpSession session) {
		if(session.getAttribute("userInfo") == null) {  	// 비로그인 > 로그인창
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
		model.addAttribute("userProfileInfo", communityService.getUserProfile(clientId, ((ClientsDTO)session.getAttribute("userInfo")).getClientId()));
		model.addAttribute("userBoard", communityService.getUserBoards(clientId, ((ClientsDTO)session.getAttribute("userInfo")).getClientId()));
		return "community/ounwangramProfile";
	}
	
	// 인바디 요청
	@RequestMapping("/inbody")
	public String showInbody(HttpSession session, Model model) {
		model.addAllAttributes(communityService.selectMyInbodyGraph(((ClientsDTO)session.getAttribute("userInfo")).getClientId()));
		return "community/inbody";
	}
	
	// 인바디 입력 페이지 요청
	@RequestMapping("/inbodyInsert")
	public String insertInbodyPage(HttpSession session, Model model) {
		model.addAttribute("inbody", communityService.selectMyInbodyInfo(((ClientsDTO)session.getAttribute("userInfo")).getClientId()));
		return "community/inbodyInsert";
	}
	
	// 팔로워 목록
	@RequestMapping("/followers")
	public String showFollowerList(@RequestParam String clientId, HttpSession session, Model model) {
		model.addAttribute("kind", "follower");
		model.addAttribute("profile", communityService.getProfile(clientId));
		model.addAttribute("followers", communityService.selectFollowerList(((ClientsDTO)session.getAttribute("userInfo")).getClientId(), clientId));
		return "community/followList";
	}
	
	// 팔로잉 목록
	@RequestMapping("/following")
	public String showFollowingList(@RequestParam String clientId, HttpSession session, Model model) {
		model.addAttribute("kind", "following");
		model.addAttribute("profile", communityService.getProfile(clientId));
		model.addAttribute("followers", communityService.selectFollowingList(((ClientsDTO)session.getAttribute("userInfo")).getClientId(), clientId));
		return "community/followList";
	}
	
	// 게시물디테일
	@RequestMapping("/gramDetail")
	public String selectOunwangramBoardDetail(@RequestParam int communityNumber, HttpSession session, Model model) {
		model.addAttribute("board", communityService.selectOunwangramBoardDetail(communityNumber, ((ClientsDTO)session.getAttribute("userInfo")).getClientId()));
		return "community/ounwangramBoardDetail";
	}
}
