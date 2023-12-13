package com.ounwan.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.CoupungDTO;
import com.ounwan.dto.GuestsDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.service.CoupungService;
import com.ounwan.service.OrderService;

@Controller
@RequestMapping("/coupung")
public class CoupungController {
	
	@Autowired
	CoupungService coupungService;
	
	
	
	@GetMapping("/products")
	public String getProductMain (Model model) {
		List<CoupungDTO> productList = coupungService.getProductList(0);
		model.addAttribute("productList", productList);
		return "coupung/order"; //수정 해야됨
	}
	
	@GetMapping("/product/category")
	public @ResponseBody ResponseEntity<?> getProductsByCategory(String categoryNum) {
		List<CoupungDTO> productList = coupungService.getProductList(Integer.parseInt(categoryNum));
		return ResponseEntity.ok(productList);
	}
	
	@GetMapping("/product/name")
	public @ResponseBody ResponseEntity<?> findByProductName(String text) {
		if(text.length() == 0) return ResponseEntity.ok(null);
		List<CoupungDTO> productList = coupungService.findByProductName(text);
		return ResponseEntity.ok(productList);
	}
	
	
	@GetMapping("/product/detail")
	public String getDetailString (@RequestParam String coupungId, Model model) {
		CoupungDTO coupung = coupungService.getProductDetail(Integer.parseInt(coupungId));
		model.addAttribute("detail", coupung);
		
		return "coupung/detail";
	}
	

	


}
