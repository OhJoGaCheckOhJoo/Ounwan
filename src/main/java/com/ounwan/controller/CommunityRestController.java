package com.ounwan.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.AetaCommentsDTO;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.AetaLikesDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.InbodyDTO;
import com.ounwan.dto.OunwanGramDTO;
import com.ounwan.service.CommunityService;

@RequestMapping("/community")
@RestController
public class CommunityRestController {

	@Autowired
	CommunityService communityService;

	@PostMapping(value = "/aetaPosting")
	public @ResponseBody String aetaInsertPost(@RequestPart(value = "images", required = false) MultipartFile[] images,
			@RequestParam(value = "imagesLength", required = false) Integer imagesLength, String title, String contents,
			HttpSession session) throws IllegalStateException, IOException {

		return (communityService.aetaInsertPost(session, title, contents, images, imagesLength) > 0) ? "success"
				: "fail";
	}

	@PostMapping(value = "/aetaUpdating")
	public @ResponseBody String aetaUpdatePost(String aetaNumber, String title, String contents, HttpSession session,
			@RequestPart(value = "newImages", required = false) MultipartFile[] newImages,
			@RequestParam(value = "newImagesLength") int newImagesLength) throws IllegalStateException, IOException {
		return (communityService.aetaUpdatePost(session, Integer.parseInt(aetaNumber), title, contents, newImages,
				newImagesLength) > 0) ? "success" : "fail";
	}

	@DeleteMapping(value = "/aetaDeletePost")
	public @ResponseBody String aeteDeletePost(HttpSession session, @RequestBody AetaDTO post) {
		ClientsDTO user = (ClientsDTO) session.getAttribute("userInfo");
		post.setClientId(user.getClientId());

		int result = communityService.aetaDeletePost(post);

		return (result > 0) ? "success" : "fail";
	}

	@PostMapping(value = "/likeButton")
	public @ResponseBody AetaLikesDTO aetaLike(@RequestParam String aetaNumber, HttpSession session) {
		ClientsDTO user = (ClientsDTO) session.getAttribute("userInfo");

		return communityService.aetaLikesButton(Integer.parseInt(aetaNumber), user);
	}

	@PostMapping(value = "/aetaInsertComment", consumes = "application/json")
	public @ResponseBody String aetaInsertComment(@RequestBody AetaCommentsDTO comment, HttpSession session) {
		ClientsDTO c = (ClientsDTO) session.getAttribute("userInfo");
		String id = c.getClientId();
		comment.setClientId(id);

		boolean result = communityService.aetaInsertComment(comment);
		return (result) ? "success" : "fail";
	}

	@DeleteMapping(value = "/aetaDeleteComment", consumes = "application/json")
	public @ResponseBody String aetaDeleteComment(@RequestBody AetaCommentsDTO comment, HttpSession session) {
		ClientsDTO c = (ClientsDTO) session.getAttribute("userInfo");
		comment.setClientId(c.getClientId());
		boolean result = communityService.aetaDeleteComment(comment);
		return (result) ? "success" : "fail";
	}

	@PostMapping("/report")
	public @ResponseBody String reportPost(@RequestBody AetaDTO aeta) {
		int result = communityService.aetaReport(aeta);
		return (result > 0) ? "success" : "fail";
	}

	@RequestMapping("/ounwangram/followBoard")
	public List<OunwanGramDTO> ounwangramFollowBoard(@RequestParam int rowNum, HttpSession session) {
		return communityService.gramFollowBoard(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), rowNum);
	}

	@RequestMapping("/ounwangram/wholeBoard")
	public List<OunwanGramDTO> ounwangramWholeBoard(@RequestParam int rowNum, HttpSession session) {
		return communityService.gramWholeBoard(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), rowNum);
	}

	@RequestMapping("/ounwangram/likeBoard")
	public Map<String, Integer> ounwangramLikeBoard(@RequestParam int communityNumber, HttpSession session) {
		return communityService.gramLikeBoard(((ClientsDTO) session.getAttribute("userInfo")).getClientId(),
				communityNumber);
	}

	@RequestMapping("/ounwangram/writeBoard")
	public String ounwanGramWriteBoard(HttpSession session, MultipartFile image, String content, String[] hashTag)
			throws IllegalStateException, IOException {
		return communityService.gramWriteBoard(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), image,
				content, hashTag);
	}

	// 게시글 수정
	@RequestMapping("/ounwangram/updateBoard")
	public String ounwanGramUpdateBoard(HttpSession session, int communityNumber, MultipartFile image, String content,
			String[] hashTag) throws IllegalStateException, IOException {
		return communityService.gramUpdateBoard(((ClientsDTO) session.getAttribute("userInfo")).getClientId(),
				communityNumber, image, content, hashTag);
	}

	@RequestMapping("/ounwangram/deleteBoard")
	public String ounwangramDeleteBoard(int communityNumber) {
		return communityService.deleteGramBoard(communityNumber);
	}

	@RequestMapping("/ounwangram/ajaxSearch")
	public List<Map<String, Object>> ounwangramAjaxSearch(String keyword) {
		return communityService.searchAjaxGram(keyword);
	}

	@RequestMapping("/ounwangram/tagBoard")
	public List<OunwanGramDTO> ounwangramTagBoard(@RequestParam int rowNum, @RequestParam String name,
			HttpSession session) {
		return communityService.searchByTag(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), rowNum,
				name);
	}

	@RequestMapping("/ounwangram/reportBoard")
	public String ounwangramReportBoard(@RequestParam int communityNumber, @RequestParam int[] reason,
			HttpSession session) {
		return communityService.reportBoard(((ClientsDTO) session.getAttribute("userInfo")).getClientId(),
				communityNumber, reason);
	}

	@RequestMapping("/insertInbody")
	public Map<String, Object> insertInbody(InbodyDTO inbody, HttpSession session, Model model) {
		return communityService.insertInbody(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), inbody);
	}

	@RequestMapping("/updateInbody")
	public Map<String, Object> updateInbody(InbodyDTO inbody, HttpSession session, Model model) {
		return communityService.updateInbody(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), inbody);
	}

	@RequestMapping("/checkFollowing")
	public int checkFollowing(@RequestParam String clientId, HttpSession session) {
		return communityService.checkFollowing(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), clientId);
	}

	@RequestMapping("/cancelFollowing")
	public int cancelFollowing(@RequestParam String clientId, HttpSession session) {
		return communityService.cancelFollowing(((ClientsDTO) session.getAttribute("userInfo")).getClientId(),
				clientId);
	}

	@RequestMapping("/addFollowing")
	public int addFollowing(@RequestParam String clientId, HttpSession session) {
		return communityService.addFollowing(((ClientsDTO) session.getAttribute("userInfo")).getClientId(), clientId);
	}
}
