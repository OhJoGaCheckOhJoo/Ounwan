package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.AdminDTO;
import com.ounwan.dto.CoupungDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.service.AdminService;
import com.ounwan.service.CoupungService;
import com.ounwan.service.OrderService;

@Controller
@RequestMapping("/admin")
public class AdminController {
	
	@Autowired
	AdminService adminService;
	
	@Autowired
	CoupungService coupungService;
	
	@Autowired
	OrderService orderService;
	
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
	
	@PostMapping("/coupung/insert.do")
	public @ResponseBody String insertProduct(@RequestBody CoupungDTO product) {
		int result = coupungService.insertProduct(product);
		return (result > 0) ? "success" : "fail";
	}
	
	@PostMapping("/coupung/update.do")
	public @ResponseBody String updateProduct(@RequestBody CoupungDTO product) {
		boolean result = coupungService.updateProduct(product);
		return (result) ? "success" : "fail";
	}
	
	@PostMapping("/coupung/delete.do")
	public @ResponseBody String deleteProduct(@RequestBody int coupungNumber) {
		boolean result = coupungService.deleteProduct(coupungNumber);
		return (result) ? "success" : "fail";
 	}
	
	@GetMapping("/coupung/products.do")
	public @ResponseBody List<CoupungDTO> getProductList() {
		return coupungService.getAdminProductList();
	}
	
	@GetMapping("/order/orderList.do")
	public @ResponseBody List<OrdersDTO> getOrderList() {
		return orderService.getAdminOrderList();
	}
	
	@PostMapping("/order/tradeStep.do")
	public @ResponseBody String updateTradeStatus(@RequestBody OrdersDTO order) {
		boolean result = orderService.updateTradeStatus(order);
		return (result) ? "success" : "fail";
	}
}
