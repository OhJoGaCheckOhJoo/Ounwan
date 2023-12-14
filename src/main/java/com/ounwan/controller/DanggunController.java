package com.ounwan.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.ClientsDTO;
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
		System.out.println("DMain_clientInfo: " + session.getAttribute("userInfo"));

		List<DanggunDTO> list = danggunService.listAll();
		ProductImagesDTO imagse = new ProductImagesDTO();

		for (DanggunDTO danggun : list) {
			ProductImagesDTO image = productImageService.selectAllImages(danggun.getDanggunNumber());
			danggun.setUrl(image.getUrl());
		}
		model.addAttribute("list", list);
		
		return "danggunMain";
	}

	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public @ResponseBody List<DanggunDTO> searchProduct(@RequestParam("searchInput") String searchInput,
			HttpSession session) {
		List<DanggunDTO> searchList = danggunService.searchProduct(searchInput);

		for (DanggunDTO danggun : searchList) {
			ProductImagesDTO searchImage = productImageService.selectAllImages(danggun.getDanggunNumber());
			danggun.setUrl(searchImage.getUrl());
		}
		return searchList;
	}

	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertGet(HttpSession session, Model model) {
		System.out.println("insertGet 왔다");

		if (session.getAttribute("userInfo") != null) {
			return "danggunInsert";
		} else {
			model.addAttribute("message", "로그인이 필요한 페이지입니다.");
			return "login";
		}

	}

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public @ResponseBody String insertPost(@RequestParam(value = "detailImagesLength", required=false) int detailImagesLength,@RequestPart(value="detailImages", required = false) MultipartFile[] detailImages, MultipartFile image,
			String clientId, String productName, int price, String detail) throws IllegalStateException, IOException {
		System.out.println("_____insertPost 왔다_______");
		System.out.println("image_C: "+image);
		return danggunService.danggunInsert(detailImagesLength, detailImages, image, clientId, productName, price, detail) ? "sucess" : "fail";
	}


}
