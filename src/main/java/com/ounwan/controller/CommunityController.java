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
import com.ounwan.service.ClientsService;
import com.ounwan.service.CommunityService;

@RequestMapping("/community")
@Controller
public class CommunityController {

	@Autowired
	CommunityService communityService;

	@Autowired
	ClientsService clientsService;

	@GetMapping("/aetaBoard")
	public String paginateBoard() {
		return "community/aeta/aetaPaginatedBoard";
	}

	@GetMapping("/aetaSearch")
	public String aetaSearch(@RequestParam(value = "inputValue", defaultValue = "%") String inputValue,
			@RequestParam(value = "selectedOption", defaultValue = "%") String selectedOption, Model model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {

		List<AetaDTO> aetaList = communityService.aetaList(page, inputValue, selectedOption);
		PaginatingDTO paginating = communityService.getPages(page, inputValue, selectedOption);
		model.addAttribute("aetaList", aetaList);
		model.addAttribute("paginating", paginating);
		model.addAttribute("countComments",communityService.aetaCountComments(page,inputValue,selectedOption));
		model.addAttribute("inputValue", inputValue);
		model.addAttribute("selectedOption", selectedOption);
		model.addAttribute("page",page);
		
		return "community/aeta/aetaSearch";
	}

	@GetMapping("/aetaPosting")
	public String aetaPostingPage(Model model, HttpSession session) {
		if (session.getAttribute("userInfo") == null) {
			return "login";
		}
		return "community/aeta/aetaPosting";
	}

	// 보류
	@GetMapping("/aetaPost")
	public String aetaReadPost(@RequestParam String aetaNumber, Model model, HttpSession session) {
		if (session.getAttribute("userInfo") == null && session.getAttribute("admin") == null) {
			model.addAttribute("loginRequired", true);
			return "login";
		} else {
			boolean updateView = communityService.aetaUpdateViews(Integer.parseInt(aetaNumber)); // 조회수 +1
			if (!updateView) {
				System.out.println("failed to update views");
			}

			// 게시글 데이터 전송
			model.addAttribute("aetaPost", communityService.aetaReadPost(Integer.parseInt(aetaNumber)));
			System.out.println(model.getAttribute("aetaPost"));
			// 좋아요 갯수
			model.addAttribute("aetaCountLikes", communityService.aetaCountLikes(Integer.parseInt(aetaNumber)));
			// 게시글 댓글 데이터 전송
			model.addAttribute("aetaComments", communityService.aetaReadComments(Integer.parseInt(aetaNumber)));
			System.out.println("\n\n\naetaReadPost controller, model댓글추가:" + model);
			// 댓글 갯수
			model.addAttribute("aetaCountComments", communityService.aetaCountComments(Integer.parseInt(aetaNumber)));
			// 접속자 좋아요 체크 여부
			if (session.getAttribute("userInfo") != null) {
				model.addAttribute("aetaLikesCheck", communityService.aetaLikesCheck(Integer.parseInt(aetaNumber),
						((ClientsDTO) session.getAttribute("userInfo")).getClientId()));
			}
			return "community/aeta/aetaPost";
		}
	}

	@GetMapping("/aetaUpdating")
	public String aetaUpdatePage(HttpSession session, Model model, @RequestParam String aetaNumber) {
		model.addAttribute("aetaPost", communityService.aetaPostToBeUpdated(Integer.parseInt(aetaNumber)));
		return "community/aeta/aetaUpdating";
	}

	@RequestMapping("/ounwangram")
	public String ounwangram(HttpSession session) {
		if (session.getAttribute("userInfo") == null)
			return "login";
		return "community/ounwangram";
	}

	@RequestMapping("/writeGramBoard")
	public String writeGramBoard() {
		return "community/writeOunwangram";
	}

	@RequestMapping("/updateGramBoard")
	public String updateGramBoard(@RequestParam int communityNumber, Model model) {
		model.addAttribute("board", communityService.aGramBoard(communityNumber));
		return "community/updateOunwangram";
	}

	@RequestMapping("/ounwanProfile")
	public String ounwanProfile(@RequestParam String clientId, HttpSession session, Model model) {
		model.addAttribute("userProfileInfo", communityService.getUserProfile(clientId,
				((ClientsDTO) session.getAttribute("userInfo")).getClientId()));
		model.addAttribute("userBoard", communityService.getUserBoards(clientId,
				((ClientsDTO) session.getAttribute("userInfo")).getClientId()));
		return "community/ounwangramProfile";
	}

	@RequestMapping("/inbody")
	public String showInbody(HttpSession session, Model model) {
		model.addAllAttributes(
				communityService.selectMyInbodyGraph(((ClientsDTO) session.getAttribute("userInfo")).getClientId()));
		return "community/inbody";
	}

	@RequestMapping("/inbodyInsert")
	public String insertInbodyPage(HttpSession session, Model model) {
		model.addAttribute("inbody",
				communityService.selectMyInbodyInfo(((ClientsDTO) session.getAttribute("userInfo")).getClientId()));
		return "community/inbodyInsert";
	}

	@RequestMapping("/followers")
	public String showFollowerList(@RequestParam String clientId, HttpSession session, Model model) {
		model.addAttribute("kind", "follower");
		model.addAttribute("profile", communityService.getProfile(clientId));
		model.addAttribute("followers", communityService
				.selectFollowerList(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), clientId));
		return "community/followList";
	}

	@RequestMapping("/following")
	public String showFollowingList(@RequestParam String clientId, HttpSession session, Model model) {
		model.addAttribute("kind", "following");
		model.addAttribute("profile", communityService.getProfile(clientId));
		model.addAttribute("followers", communityService
				.selectFollowingList(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), clientId));
		return "community/followList";
	}

	@RequestMapping("/gramDetail")
	public String selectOunwangramBoardDetail(@RequestParam int communityNumber, HttpSession session, Model model) {
		model.addAttribute("board", communityService.selectOunwangramBoardDetail(communityNumber,
				((ClientsDTO) session.getAttribute("userInfo")).getClientId()));
		return "community/ounwangramBoardDetail";
	}
}
