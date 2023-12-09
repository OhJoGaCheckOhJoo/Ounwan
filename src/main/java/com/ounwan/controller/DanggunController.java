package com.ounwan.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.service.DanggunService;
import com.ounwan.service.ProductImagesService;
import com.ounwan.service.WishListsService;

@RequestMapping("/danggun")
@Controller
public class DanggunController {
	@Autowired
	DanggunService danggunService;
	
	@Autowired
	ProductImagesService productImagesService;
	
	@Autowired
	WishListsService wishListsService;
	
	@GetMapping(value = "/detail", produces = "application/json")
	public String danggunDetail(Model model,@RequestParam ("danggunNumber") int danggunNumber ) {
		System.out.println("왔나 : " + danggunNumber);
		
		DanggunDTO resultDanggun = danggunService.selectDanggun(danggunNumber);
		System.out.println(resultDanggun);
		if(resultDanggun == null) System.out.println("실패다 이새끼야");
		else model.addAttribute("post", resultDanggun);
		
		List<ProductImagesDTO> resultImages = productImagesService.selectImages(danggunNumber);
		if(resultImages == null) System.out.println("이미지도 없다.");
		else model.addAttribute("danggunImage", resultImages);
		
		model.addAttribute("zzimCount",wishListsService.selectCountZzim(danggunNumber));
		
		return "danggun/danggunDetail";
	}

}
