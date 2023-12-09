package com.ounwan.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.CoupungDTO;
import com.ounwan.dto.GuestsDTO;
import com.ounwan.dto.OrderDetailsDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.service.CoupungService;

@Controller
@RequestMapping("/coupung")
public class CoupungController {
	
	@Autowired
	CoupungService coupungService;
	
	@ResponseBody
	@GetMapping("/product")
	public ResponseEntity<?> getProducts(@RequestParam String id) {
		int categoryId = Integer.parseInt(id);
		List<CoupungDTO> productList = coupungService.getProductList(categoryId);
		if (productList.isEmpty())
			return new ResponseEntity<>("fail", HttpStatus.INTERNAL_SERVER_ERROR);
		return new ResponseEntity<>(productList, HttpStatus.OK);
	}
	
	@GetMapping("/product/detail")
	public String getDetailString (@RequestParam String coupungId, Model model) {
		CoupungDTO coupung = coupungService.getProductDetail(coupungId);
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
		CoupungDTO coupung = coupungService.getProductDetail(coupungId);
		
		model.addAttribute("detail", coupung);
		
 		return "/coupung/hot-deal/detail";
	}
	
	@GetMapping("/order")
	public String getOrderPage(@RequestParam List<OrderDetailsDTO> productList, Model model) {
		List<OrderDetailsDTO> result = new ArrayList<>();
		for (OrderDetailsDTO order : productList) {
			order.setCoupungDTO(coupungService.getProductDetail(order.getCoupungNumber()));
			result.add(order);
		}
		model.addAttribute("products", result);
		
		return "/coupung/order";
	}
	
	@PostMapping("/order")
	public @ResponseBody String setOrder(@RequestParam OrdersDTO order, HttpSession session) {
		ClientsDTO client = (ClientsDTO) session.getAttribute("client");
		GuestsDTO guest = (GuestsDTO) session.getAttribute("guest");
		
		if (client == null && guest == null) {
			session.setAttribute("guestOrderList", order.getOrderDetails());
			return "empty";
		}
		
		
		
		return null;
	}
}
