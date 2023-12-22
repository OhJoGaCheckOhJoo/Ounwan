package com.ounwan.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.MyPageService;

@RequestMapping("/myPage")
@Controller
public class MyPageController {

	@Autowired
	MyPageService myPageService;
	
	String id = "jj1234";
	
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
		
		return "/myPage/coupungOrderList";
	}
	
	@RequestMapping(value = "/danggunSaleList", method = RequestMethod.GET)
	public String DanggunSaleList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();	
		
		model.addAttribute("danggunSaleList", myPageService.getDanggunSaleList(id));			

		return "/myPage/danggunSaleList";
	}
	
	@RequestMapping(value = "/danggunWishList", method = RequestMethod.GET)
	public String DanggunWishList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();		
		
		model.addAttribute("danggunWishList", myPageService.getDanggunWishList(id));
		
		return "/myPage/danggunWishList";
	}
	
	@RequestMapping(value ="/deleteDanggunWishList", method = RequestMethod.POST)
	public String deleteWishList(@RequestBody Map<String, List<String>> payload, HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
//		String clientId = userInfo.getClientId();
		
		List<String> selectedWishLists = payload.get("selectedWishLists");

		myPageService.deleteWishList(selectedWishLists);
		
		List<Map<String, Object>> updateWishLists = myPageService.getDanggunWishList(id);
		model.addAttribute("danggunWishList", updateWishLists);
		
		return "/myPage/danggunWishList";
	}
	
	@RequestMapping(value = "/aetaList", method = RequestMethod.GET)
	public String AetaList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
//		String clientId = userInfo.getClientId();		
		
		model.addAttribute("aetaList", myPageService.getAetaList(id));
		
		return "/myPage/aetaList";
	}
	
	@RequestMapping(value ="/coupungReviewList", method = RequestMethod.GET)
	public String reviewList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
//		String clientId = userInfo.getClientId();
		
		model.addAttribute("coupungReviewList", myPageService.getReviewList(id));
		
		return "/myPage/coupungReviewList";
	}
	
	@RequestMapping(value ="/deleteCoupungReviewList", method = RequestMethod.POST)
	public String deleteReviewList(@RequestBody Map<String, List<String>> payload, HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
//		String clientId = userInfo.getClientId();
		
		List<String> selectedReviews = payload.get("selectedReviews");

		myPageService.deleteReviewList(selectedReviews);
		
		List<Map<String, Object>> updateReview = myPageService.getReviewList(id);
		model.addAttribute("coupungReviewList", updateReview);
		
		return "/myPage/coupungReviewList";
	}

}
