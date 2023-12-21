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
import com.ounwan.service.ProductImagesService;

@RequestMapping("/myPage")
@Controller
public class MyPageController {

	@Autowired
	MyPageService myPageService;

	@Autowired
	ProductImagesService productImagesService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String myPage(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();
		
		model.addAttribute("wishListCount", myPageService.getWishListCount(clientId));
		model.addAttribute("cartListCount", myPageService.getCartListCount(clientId));
		
		model.addAttribute("orderList", myPageService.orderListPreview(clientId));
		model.addAttribute("aetaList", myPageService.aetaListPreview(clientId));
		model.addAttribute("cartList", myPageService.cartListPreview(clientId));
		
		return "/myPage/myPage";
	}

	@RequestMapping(value = "/danggunSaleList", method = RequestMethod.GET)
	public String DanggunSaleList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();	
		
		model.addAttribute("danggunSaleList", myPageService.getDanggunSaleList(clientId));			

		return "/myPage/danggunSaleList";
	}
	
	@RequestMapping(value = "/danggunWishList", method = RequestMethod.GET)
	public String DanggunWishList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();		
		
		model.addAttribute("danggunWishList", myPageService.getDanggunWishList(clientId));
		
		return "/myPage/danggunWishList";
	}
	
	@RequestMapping(value ="/deleteDanggunWishList", method = RequestMethod.POST)
	public String deleteWishList(@RequestBody Map<String, List<String>> payload, HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
		String clientId = userInfo.getClientId();
		
		List<String> selectedWishLists = payload.get("selectedWishLists");

		myPageService.deleteWishList(selectedWishLists);
		
		List<Map<String, Object>> updateWishLists = myPageService.getDanggunWishList(clientId);
		model.addAttribute("danggunWishList", updateWishLists);
		
		return "/myPage/danggunWishList";
	}
	
	@RequestMapping(value = "/aetaList", method = RequestMethod.GET)
	public String AetaList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = userInfo.getClientId();		
		
		model.addAttribute("aetaList", myPageService.getAetaList(clientId));
		
		return "/myPage/aetaList";
	}
	
	@RequestMapping(value ="/coupungReviewList", method = RequestMethod.GET)
	public String reviewList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
		String clientId = userInfo.getClientId();
		
		model.addAttribute("coupungReviewList", myPageService.getReviewList(clientId));
		
		return "/myPage/coupungReviewList";
	}
	
	@RequestMapping(value ="/deleteCoupungReviewList", method = RequestMethod.POST)
	public String deleteReviewList(@RequestBody Map<String, List<String>> payload, HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");		
		String clientId = userInfo.getClientId();
		
		List<String> selectedReviews = payload.get("selectedReviews");

		myPageService.deleteReviewList(selectedReviews);
		
		List<Map<String, Object>> updateReview = myPageService.getReviewList(clientId);
		model.addAttribute("coupungReviewList", updateReview);
		
		return "/myPage/coupungReviewList";
	}

}
