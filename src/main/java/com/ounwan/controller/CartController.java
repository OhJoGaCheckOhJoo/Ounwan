package com.ounwan.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.CartsDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.CartService;

@Controller
@RequestMapping("/coupung")
public class CartController {
	@Autowired
	CartService cartService;
	
	@GetMapping("/cart")
	public String showClientCart(HttpSession session) {
	    ClientsDTO client = (ClientsDTO) session.getAttribute("userInfo");
	    if (client == null) {
	    	List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");
	        session.setAttribute("cartList", cartList);
	    } 
	    return "coupung/cart";
	}

	@PostMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String addCart(@RequestBody CartsDTO cartsDTO, HttpSession session) {
		ClientsDTO client = (ClientsDTO) session.getAttribute("userInfo");
		if (client == null) {
			List<CartsDTO> cartList = cartService.addGuestCart((List<CartsDTO>) session.getAttribute("cartList"), cartsDTO);
			session.setAttribute("cartList", cartList);
			return (cartList != null) ? "success" : "fail"; 
		}
		List<Map<String, Object>> cartList = cartService.addToCart(cartsDTO, client.getClientId());
		session.setAttribute("userCartList", cartList);
		return (cartList != null) ? "success" : "fail"; 
	}

	@GetMapping(value = "/cartUpdate", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String updateCart(@RequestParam Integer coupungNumber
											, @RequestParam int quantity
											, @RequestParam Integer coupungOptionNumber
											, HttpSession session) {
		System.out.println(coupungOptionNumber);
		ClientsDTO client = (ClientsDTO) session.getAttribute("userInfo");
		if (client == null) {
			List<CartsDTO> cartList = cartService.updateGuestCart((List<CartsDTO>) session.getAttribute("cartList"), coupungNumber, coupungOptionNumber,quantity);
			session.setAttribute("cartList", cartList);
			return (cartList != null) ? "success" : "fail";
		}
		List<Map<String, Object>> cartList = cartService.updateCart(coupungNumber, coupungOptionNumber, quantity, client.getClientId());
		session.setAttribute("userCartList", cartList);
		return (cartList != null) ? "success" : "fail";
	}

	@GetMapping(value = "/cartDelete", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String deleteCart(@RequestParam("coupungNumber") Integer coupungNumber
											, @RequestParam("optionNumber") Integer optionNumber
											, HttpSession session) {
		ClientsDTO client = (ClientsDTO) session.getAttribute("userInfo");
		if (client == null) {
			List<CartsDTO> cartList = cartService.deleteGuestCart(coupungNumber, optionNumber, (List<CartsDTO>) session.getAttribute("cartList"));
			session.setAttribute("cartList", cartList);
			return (cartList != null) ? "success" : "fail"; 
		}
		List<Map<String, Object>> cartList = cartService.deleteCart(coupungNumber, optionNumber, client.getClientId());
		session.setAttribute("userCartList", cartList);
		return (cartList != null) ? "success" : "fail";
	}
}
