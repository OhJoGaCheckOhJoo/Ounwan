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
	@Autowired
	OrderService orderService;
	
	
	
	@GetMapping("/products")
	public String getProductMain (Model model) {
		List<CoupungDTO> productList = coupungService.getProductList(0);
		model.addAttribute("productList", productList);
		return "coupung/products";
	}
	
	@GetMapping("/product/category")
	public @ResponseBody ResponseEntity<?> getProductsByCategory(@RequestParam String categoryNum) {
		List<CoupungDTO> productList = coupungService.getProductList(Integer.parseInt(categoryNum));
		return ResponseEntity.ok(productList);
	}
	
	@GetMapping("/product/name")
	public @ResponseBody ResponseEntity<?> findByProductName(@RequestParam String text) {
		if(text.length() == 0) return ResponseEntity.ok(null);
		List<CoupungDTO> productList = coupungService.findByProductName(text);
		return ResponseEntity.ok(productList);
	}
	
	
	@GetMapping("/product/detail")
	public String getDetailString (@RequestParam String coupungId, Model model) {
		CoupungDTO coupung = coupungService.getProductDetail(Integer.parseInt(coupungId));
		model.addAttribute("detail", coupung);
		
		return "/coupung/detail";
	}
	
	@GetMapping("/hot-deal")
	public String getHotDeal(HttpSession session, Model model) {
		String clientId = (String) session.getAttribute("clientId");
		boolean history = coupungService.checkOrderHistory(clientId);
		List<CoupungDTO> productList = coupungService.getHotDealProductList();
		
		model.addAttribute("history", history);
		model.addAttribute("products", productList);
		
		return "/coupung/hot-deal";
	}
	
	@GetMapping("/hot-deal/detail")
	public String getHotDealDetail(@RequestParam String coupungId, Model model) {
		CoupungDTO coupung = coupungService.getProductDetail(Integer.parseInt(coupungId));
		
		model.addAttribute("detail", coupung);
		
 		return "/coupung/hot-deal/detail";
	}
	
	@GetMapping("/order")
	public String getOrderPage(@RequestParam List<String> productList, Model model) {
		List<CoupungDTO> result = new ArrayList<>();
		for (String coupungNubmer : productList) {
			CoupungDTO order = coupungService.getProductDetail(Integer.parseInt(coupungNubmer));
			result.add(order);
		}
		model.addAttribute("products", result);
		
		return "coupung/order";
	}
	
	@PostMapping("/order")
	public @ResponseBody String setOrder(@RequestBody OrdersDTO order, HttpSession session) {
		ClientsDTO client = (ClientsDTO) session.getAttribute("client");
		GuestsDTO guest = (GuestsDTO) session.getAttribute("guest");
		if (client == null && guest == null) {
			session.setAttribute("guestOrderList", order.getOrderDetails());
			return "empty";
		}

//		ClientsDTO client = null;
//		GuestsDTO guest = GuestsDTO.builder().guestNumber(2).email("yyy@gmail.com").phone("010-1234-1234").build();
		boolean result = orderService.setOrder(order, client, guest);
		
		return (result) ? "success" : "fail";
	}
}
