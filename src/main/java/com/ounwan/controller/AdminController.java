package com.ounwan.controller;

import java.util.Arrays;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.AdminDTO;
import com.ounwan.dto.CoupungDTO;
import com.ounwan.service.AdminService;
import com.ounwan.service.CoupungService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	CoupungService coupungService;
	
	@GetMapping("/main.do")
	public String getMainPage(HttpSession session) {
		System.out.println((AdminDTO)session.getAttribute("admin"));
		if(session.getAttribute("admin") == null)
			return "admin/login";
		return "admin/home";
	}
	
	@GetMapping("/login.do")
	public String getLoginPage() {
		return "admin/login";
	}
	
	@PostMapping("login.do")
	public @ResponseBody String checkAuthorization(@RequestBody AdminDTO adminDTO, HttpSession session) {
		AdminDTO result = adminService.checkAuthorization(adminDTO);
		if (result != null) {
			session.setAttribute("admin", result);
			return "success";
		}
		return "fail";
	}
	
	@GetMapping("/coupung/select.do")
	public String getProductPage() {
		return "admin/product";
	}
	
	@GetMapping("/coupung/insert.do")
	public String getProductDetailPage() {
		return "admin/productDetail";
	}
	
	@PostMapping("/coupung/addProduct")
	public String addProduct(@RequestPart MultipartFile mainImage, 
						@RequestPart(required=false) MultipartFile[] subImage,
						@RequestPart(required=false) MultipartFile[] explanationImg,
						String name,
						int price) {
		System.out.println(mainImage);
		System.out.println(Arrays.toString(subImage));
		System.out.println(Arrays.toString(explanationImg));
		System.out.println(name);
		System.out.println(price);
		return null;
	}
	
	@GetMapping("/coupung/searchProduct")
	public String searchProduct(@RequestParam String searchOption, @RequestParam String searchValue) {
		System.out.println(searchOption + " : " + searchValue);
		return "admin/product";
	}
	
	@GetMapping("/coupung/sortProduct")
	public String sortProduct(@RequestParam String sort, @RequestParam String searchOption, @RequestParam String searchValue) {
		System.out.println("정렬옵션 : " + sort + "\n" + searchOption + " : " + searchValue);
		return "admin/product";
	}
	
	@PostMapping("/coupung/insert.do")
	public @ResponseBody String insertProduct(@RequestBody CoupungDTO product) {
		// int result = coupungService.insertProduct(product);
		// return (result > 0) ? "success" : "fail";
		return "";
	}
}