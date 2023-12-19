package com.ounwan.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.ounwan.dto.AetaDTO;
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
	public String myPage(HttpSession session, String clientId) {
		return "/myPage/myPage";
	}

	@RequestMapping(value = "/danggunSaleList", method = RequestMethod.GET)
	public String DanggunSaleList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");	
		String clientId = userInfo.getClientId();
		
		List<Map<String, Object>> list = myPageService.getDanggunSaleList(clientId);	
		model.addAttribute("danggunSaleList", list);			

		return "/myPage/danggunSaleList";
	}
	
	@RequestMapping(value = "/danggunWishList", method = RequestMethod.GET)
	public String DanggunWishList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");	
		String clientId = userInfo.getClientId();
		
		List<Map<String, Object>> list = myPageService.getDanggunWishList(clientId);
		model.addAttribute("danggunWishList", list);
		
		return "/myPage/danggunWishList";
	}
	
	@RequestMapping(value = "/aetaList", method = RequestMethod.GET)
	public String AetaList(HttpSession session, Model model) {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");	
		String clientId = userInfo.getClientId();
		
		List<AetaDTO> list = myPageService.getAetaList(clientId);
		model.addAttribute("aetaList", list);
		
		return "/myPage/aetaList";
	}

}
