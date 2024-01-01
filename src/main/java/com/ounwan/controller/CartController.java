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
	public String showClientCart(Model model, HttpSession session) {
	    Object obj = session.getAttribute("userInfo");

	    List<Map<Object, Object>> UserCartList = new ArrayList<>();
	    List<CartsDTO> cartList = null;
	    if (obj == null) {
	    	cartList = (List<CartsDTO>) session.getAttribute("cartList");
	        model.addAttribute("GuestCartList", cartList);
	    } else {
	        UserCartList = cartService.getCartById(((ClientsDTO) obj).getClientId());
	        model.addAttribute("clientId", ((ClientsDTO) obj).getClientId());
	    }
	    model.addAttribute("UserCartList", UserCartList);

	    int total = 0;
	    for (Map<Object, Object> map : UserCartList) {
	        total += (Integer) map.get("price") * (Integer) map.get("QUANTITY");
	    }
	    model.addAttribute("total", total);

	    return "coupung/cart";
	}

	@PostMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String addCart(@RequestBody CartsDTO cartsDTO, HttpSession session) {
		Object obj = session.getAttribute("userInfo");
		List<CartsDTO> cartList = null;
		if (obj == null) {
			Object prevCartList = session.getAttribute("cartList");
			if (prevCartList == null) {
				cartList = new ArrayList<>();
				cartList.add(cartsDTO);
			} else {
				cartList = (List<CartsDTO>) prevCartList;
				boolean updateOK = false;
				for (CartsDTO dto : cartList) {
					if (dto.getCoupungNumber() == cartsDTO.getCoupungNumber() && dto.getCoupungOptionNumber() == cartsDTO.getCoupungOptionNumber()) {
						dto.setQuantity(dto.getQuantity() + cartsDTO.getQuantity());
						updateOK = true;
						break;
					}
				}
				if (updateOK == false)
					cartList.add(cartsDTO);
			}
			session.setAttribute("cartList", cartList);
		} else {
			ClientsDTO client = (ClientsDTO) obj;
			cartsDTO.setClientId(client.getClientId());
			cartService.addToCart(cartsDTO);
		}
		return "success";
	}

	@GetMapping(value = "/cartUpdate", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String updateCart(@RequestParam Integer coupungNumber, @RequestParam int quantity,
			HttpSession session) {
		Object obj = session.getAttribute("userInfo");
		CartsDTO cartsDTO = CartsDTO.builder().coupungNumber(coupungNumber).quantity(quantity).build();

		if (obj == null) {
			List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");
			if (cartList != null) {
				for (CartsDTO cart : cartList) {
					if (cart.getCoupungNumber() == coupungNumber) {
						cart.setQuantity(quantity);
						break;
					}
				}
				session.setAttribute("cartList", cartList);
			}
		} else {
			ClientsDTO client = (ClientsDTO) obj;
			cartsDTO.setClientId(client.getClientId());
			cartService.updateCart(cartsDTO);
		}
		return "cart";
	}

	@GetMapping(value = "/cartDelete", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String deleteCart(@RequestParam("coupungNumber") Integer coupungNumber, @RequestParam("optionNumber") Integer optionNumber, HttpSession session) {
		Object obj = session.getAttribute("userInfo");
		CartsDTO cartsDTO = CartsDTO.builder().coupungNumber(coupungNumber).coupungOptionNumber(optionNumber).build();
		if (obj == null) {
			List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");
			if (cartList != null) {
				cartList.removeIf(cart -> ((CartsDTO) cart).getCoupungNumber() == coupungNumber);
				session.setAttribute("cartList", cartList);
			}
		} else {
			ClientsDTO client = (ClientsDTO) obj;
			cartsDTO.setClientId(client.getClientId());
			cartService.deleteCart(cartsDTO);
		}
		return "cart";
	}
}
