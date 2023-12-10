package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.service.DanggunService;
import com.ounwan.service.ProductImagesService;

@RequestMapping("/danggun")
@Controller
public class DanggunController {

	@Autowired
	DanggunService danggunService;
	
	@Autowired
	ProductImagesService productImageService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainGet(HttpSession session, Model model) {
		session.getAttribute("clientId");
		List<DanggunDTO> list = danggunService.listAll();					
		for(DanggunDTO danggun: list) {
			ProductImagesDTO image = productImageService.selectAllImages(danggun.getDanggunNumber());
			danggun.setUrl(image.getUrl());	
		}			
		model.addAttribute("list", list);
		return "danggunMain";
	}

	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public @ResponseBody List<DanggunDTO> searchProduct(@RequestParam ("searchInput") String searchInput, HttpSession session) {	
		List<DanggunDTO> searchList = danggunService.searchProduct(searchInput);		
		for(DanggunDTO danggun : searchList ) {
			ProductImagesDTO searchImage = productImageService.selectAllImages(danggun.getDanggunNumber());
			danggun.setUrl(searchImage.getUrl());
		}		
		return searchList;
	}
}
