package com.ounwan.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.oauth.kakao.KakaoLoginBO;
import com.ounwan.service.ClientsService;
import com.ounwan.service.MyPageService;

@RequestMapping("/myPage")
@Controller
public class MyPageController {
	

	@Autowired
	ClientsService clientService;

	@Autowired
	MyPageService myPageService;
	
	@Autowired
	KakaoLoginBO kakaoLogin;

	String id="jj1234";
	
	@RequestMapping(method = RequestMethod.GET)
	public String myPage(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();
		
		model.addAttribute("wishListCount", myPageService.getWishListCount(id));
		model.addAttribute("cartListCount", myPageService.getCartListCount(id));
		
		model.addAttribute("orderList", myPageService.orderListPreview(id));
		model.addAttribute("aetaList", myPageService.aetaListPreview(id));
		model.addAttribute("cartList", myPageService.cartListPreview(id));
		
		return "/myPage/myPage";
	}

	///###################여기 하는 중###############
	@RequestMapping(value = "/coupungOrderList", method = RequestMethod.GET)
	public String coupungOrderList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();	
		
		List<Map<String, Object>> lists = myPageService.getCoupungOrderList(id);
		System.out.println("lists: " + lists);
		
		model.addAttribute("coupungOrderList", lists);
		
		return "myPage/coupungOrderList";
	}
	
	@RequestMapping(value = "/danggunSaleList", method = RequestMethod.GET)
	public String DanggunSaleList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();	
		
		model.addAttribute("danggunSaleList", myPageService.getDanggunSaleList(id));			

		return "myPage/danggunSaleList";
	}
	
	@RequestMapping(value = "/danggunWishList", method = RequestMethod.GET)
	public String DanggunWishList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();		
		
		model.addAttribute("danggunWishList", myPageService.getDanggunWishList(id));
		
		return "myPage/danggunWishList";
	}
	
	@RequestMapping(value ="/deleteDanggunWishList", method = RequestMethod.POST)
	public String deleteWishList(@RequestBody Map<String, List<String>> payload, HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
//		String clientId = userInfo.getClientId();
		
		List<String> selectedWishLists = payload.get("selectedWishLists");

		myPageService.deleteWishList(selectedWishLists);
		
		List<Map<String, Object>> updateWishLists = myPageService.getDanggunWishList(id);
		model.addAttribute("danggunWishList", updateWishLists);
		
		return "myPage/danggunWishList";
	}
	
	@RequestMapping(value = "/aetaList", method = RequestMethod.GET)
	public String AetaList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();		
		
		model.addAttribute("aetaList", myPageService.getAetaList(id));
		
		return "myPage/aetaList";
	}
	
	@RequestMapping(value ="/coupungReviewList", method = RequestMethod.GET)
	public String reviewList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
//		String clientId = userInfo.getClientId();
		
		model.addAttribute("coupungReviewList", myPageService.getReviewList(id));
		
		return "myPage/coupungReviewList";
	}
	
	@RequestMapping(value ="/deleteCoupungReviewList", method = RequestMethod.POST)
	public String deleteReviewList(@RequestBody Map<String, List<String>> payload, HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
//		String clientId = userInfo.getClientId();
		
		List<String> selectedReviews = payload.get("selectedReviews");

		myPageService.deleteReviewList(selectedReviews);
		
		List<Map<String, Object>> updateReview = myPageService.getReviewList(id);
		model.addAttribute("coupungReviewList", updateReview);
		
		return "myPage/coupungReviewList";
	}


	@GetMapping(value = "/checkPwd")
	public String checkPwd(HttpSession session) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();	
		
		return "myPage/checkPwd";
	}

	@RequestMapping(value = "/checkPwd", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String checkPwd(String enteredPassword, HttpSession session) {
		
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();	
		String storedPassword = myPageService.getPwdById(id); 

		if (storedPassword != null && BCrypt.checkpw(enteredPassword, storedPassword)) {
			return "success";
		}
		return "fail";
	}
	
	@RequestMapping(value = "/modifyUserInfo", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String showUserInfo(HttpSession session, Model model) {
		
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();	
		
		ClientsDTO clientInfo = myPageService.getUserInfo(id);
		model.addAttribute("clientInfo", clientInfo);
		return "myPage/modifyUserInfo"; // 회원정보 수정 페이지의 뷰 이름
	}


	@RequestMapping(value = "/modifyUserInfo/pwd", method = RequestMethod.POST, consumes = "application/json")
	public @ResponseBody String modifyPwd(@RequestBody ClientsDTO clientsDTO, HttpSession session) throws Exception {
		int result = myPageService.modifyPwd(clientsDTO);
		
		if (result > 0) {
			System.out.println("YESSSSSS");
		} else {
			System.out.println("NOOOOOOOOO");
		}
		return "success";
	}

	@RequestMapping(value = "/modifyUserInfo", method = RequestMethod.POST, consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String modifyUserInfo(@RequestBody ClientsDTO clientsDTO) {
		myPageService.modifyUserInfo(clientsDTO);
		return "success";

	}
	
	@PostMapping(value="/updateImg")
	public @ResponseBody String updateImage(@RequestParam("image") MultipartFile image,  @RequestParam("clientId") String clientId) {
		String imgString = myPageService.updateImage(image, clientId);
	    return imgString;
	}
	
	@RequestMapping(value="/withdrawal", method = RequestMethod.POST, consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String withdrawUserInfo(@RequestBody ClientsDTO clientsDTO,  HttpSession session) {
		myPageService.withdrawUserInfo(clientsDTO);
		
		String accessToken = (String) session.getAttribute("accessToken");
		if (accessToken != null) {
			kakaoLogin.logout(session);
			session.invalidate();
			return "success";
		}
		session.invalidate();
		
		return "success";
	}

}
