package com.ounwan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.service.DanggunService;
import com.ounwan.service.ProductImagesService;
import com.ounwan.service.TradeHistoryService;
import com.ounwan.service.WishListsService;

@RequestMapping("/danggun")
@Controller
public class DanggunController {
	@Autowired
	DanggunService danggunService;
	
	@Autowired
	ProductImagesService productImagesService;
	
	@Autowired
	TradeHistoryService tradeHistoryService;
	
	@Autowired
	WishListsService wishListsService;
	
	@GetMapping("/main")
	public String danggunMain() {
		return "/danggun/danggunMain";
	}
	
//	상품 상세 목록 조회하기 
	@GetMapping(value = "/detail")
	public ModelAndView danggunDetail(@RequestParam ("danggunNumber") int danggunNumber ) {
		ModelAndView mv = new ModelAndView("danggun/danggunDetail");
		
		DanggunDTO resultDanggun = danggunService.selectDanggun(danggunNumber);
		if(resultDanggun != null) {
			mv.addObject("post", resultDanggun);
			int tradeHistoryNumber = resultDanggun.getTradeHistoryNumber();
			String step = tradeHistoryService.selectTradeStep(tradeHistoryNumber);
			mv.addObject("tradeStep", step);
		}
		
		List<ProductImagesDTO> resultImages = productImagesService.selectImages(danggunNumber);
		System.out.println(resultImages);
		if(resultImages != null) mv.addObject("danggunImage", resultImages);
		
		mv.addObject("zzimCount",wishListsService.selectCountZzim(danggunNumber));
		
		return mv;
	}
	
}
