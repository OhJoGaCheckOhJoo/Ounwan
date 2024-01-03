package com.ounwan.controller;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.RefundsDTO;
import com.ounwan.oauth.kakao.KakaoLoginBO;
import com.ounwan.service.ClientsService;
import com.ounwan.service.MyPageService;
import com.ounwan.service.RefundsService;
import com.ounwan.service.ReviewsService;

@RequestMapping("/myPage")
@Controller
public class MyPageController {

	@Autowired
	ClientsService clientService;

	@Autowired
	MyPageService myPageService;
	
	@Autowired
	KakaoLoginBO kakaoLogin;

	@Autowired
	RefundsService refundsService;
	
	@Autowired
	ReviewsService reviewService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String myPage(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		
		if(userInfo==null) {
			return "login";
		}
		String clientId = userInfo.getClientId();
		
		model.addAttribute("wishListCount", myPageService.getWishListCount(clientId));
		model.addAttribute("cartListCount", myPageService.getCartListCount(clientId));
		
		model.addAttribute("orderList", myPageService.orderListPreview(clientId));
		model.addAttribute("aetaList", myPageService.aetaListPreview(clientId));
		model.addAttribute("cartList", myPageService.cartListPreview(clientId));
		
		return "/myPage/myPage";
	}

	@RequestMapping(value = "/coupungOrderList", method = RequestMethod.GET)
	public String coupungOrderList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();	
		
		List<Map<String, Object>> lists = myPageService.getCoupungOrderList(clientId);
		
		model.addAttribute("coupungOrderList", lists);
		
		return "myPage/coupungOrderList";
	}
	
	@RequestMapping(value = "/refund", method= RequestMethod.POST) 
	public @ResponseBody String OrderRefund(@RequestBody RefundsDTO refund) {
		return refundsService.orderRefund(refund)? "success" : "fail";
	}
	
	@RequestMapping(value = "/confirmPurchase", method = RequestMethod.POST)
	public @ResponseBody String PurchaseConfirm(String orderNumber) {			
		return myPageService.changeConfirmState(orderNumber)? "success" : "fail";
	}
	
	@RequestMapping(value="/writeReview", method = RequestMethod.POST)
	public @ResponseBody String writeReview(@RequestPart(value = "reviewImage", required = false) MultipartFile reviewImage, int reviewDetailNumber,  Double reviewScore, String reviewContent) throws IllegalStateException, IOException {		
		return reviewService.writeReview(reviewImage, reviewDetailNumber, reviewScore, reviewContent)? "success" :"fail";
	}
	
	@RequestMapping(value = "/danggunSaleList", method = RequestMethod.GET)
	public String DanggunSaleList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();	
		
		model.addAttribute("danggunSaleList", myPageService.getDanggunSaleList(clientId));			

		return "myPage/danggunSaleList";
	}
	
	@RequestMapping(value = "/danggunWishList", method = RequestMethod.GET)
	public String DanggunWishList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();		
		
		model.addAttribute("danggunWishList", myPageService.getDanggunWishList(clientId));
		
		return "myPage/danggunWishList";
	}
	
	@RequestMapping(value ="/deleteDanggunWishList", method = RequestMethod.POST)
	public String deleteWishList(@RequestBody Map<String, List<String>> payload, HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
		String clientId = userInfo.getClientId();
		
		List<String> selectedWishLists = payload.get("selectedWishLists");

		myPageService.deleteWishList(selectedWishLists);
		
		List<Map<String, Object>> updateWishLists = myPageService.getDanggunWishList(clientId);
		model.addAttribute("danggunWishList", updateWishLists);
		
		return "myPage/danggunWishList";
	}
	
	@RequestMapping(value = "/aetaList", method = RequestMethod.GET)
	public String AetaList(HttpSession session, Model model,
			@RequestParam(value="page",required=false,defaultValue="1")int page) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();		
		
		model.addAttribute("aetaList", myPageService.getAetaList(clientId,page));
		model.addAttribute("pages", myPageService.getPages(page, clientId));
		return "myPage/aetaList";
	}
	
	@RequestMapping(value ="/coupungReviewList", method = RequestMethod.GET)
	public String reviewList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
		String clientId = userInfo.getClientId();
		
		model.addAttribute("coupungReviewList", myPageService.getReviewList(clientId));
		
		return "myPage/coupungReviewList";
	}
	
	@RequestMapping(value ="/deleteCoupungReviewList", method = RequestMethod.POST)
	public String deleteReviewList(@RequestBody Map<String, List<String>> payload, HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
		String clientId = userInfo.getClientId();
		
		List<String> selectedReviews = payload.get("selectedReviews");

		myPageService.deleteReviewList(selectedReviews);
		
		List<Map<String, Object>> updateReview = myPageService.getReviewList(clientId);
		model.addAttribute("coupungReviewList", updateReview);
		
		return "myPage/coupungReviewList";
	}


	@GetMapping(value = "/checkPwd")
	public String checkPwd(HttpSession session) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();	
		
		return "myPage/checkPwd";
	}

	@RequestMapping(value = "/checkPwd", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String checkPwd(String enteredPassword, HttpSession session) {
		
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();	
		String storedPassword = myPageService.getPwdById(clientId); 

		if (storedPassword != null && BCrypt.checkpw(enteredPassword, storedPassword)) {
			return "success";
		}
		return "fail";
	}
	
	@GetMapping("/modifyUserInfo")
	public String showUserInfo() {
		return "myPage/modifyUserInfo";
	}


	@RequestMapping(value = "/modifyUserInfo/pwd", method = RequestMethod.POST, consumes = "application/json")
	public @ResponseBody String modifyPwd(@RequestBody ClientsDTO clientsDTO, HttpSession session) throws Exception {
		int result = myPageService.modifyPwd(clientsDTO);
		return (result > 0) ? "success" : "fail";
	}

	@RequestMapping(value = "/modifyUserInfo", method = RequestMethod.POST, consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String modifyUserInfo(@RequestBody ClientsDTO clientsDTO, HttpSession session) {
		ClientsDTO updateInfo = myPageService.modifyUserInfo(clientsDTO);
		if(updateInfo==null) return "fail";
		session.setAttribute("updateInfo", updateInfo);
		return "success";

	}
	
	@PostMapping(value="/updateImg")
	public @ResponseBody String updateImage(@RequestParam("image") MultipartFile image, HttpSession session) throws IllegalStateException, IOException {
		ClientsDTO client = (ClientsDTO) (session.getAttribute("userInfo"));
		ClientsDTO updateInfo = myPageService.updateImage(image, client);
		if(updateInfo.getProfileUrl() == null)
			return "fail";
		session.setAttribute("userInfo", updateInfo);
	    return "success";
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
