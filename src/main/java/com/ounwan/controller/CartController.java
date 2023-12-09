package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.CartsDTO;
import com.ounwan.service.CartService;

@Controller
@RequestMapping("/coupung")
public class CartController {

	@Autowired
	CartService cartService;

	@GetMapping("/cart")
	public String showClientCart(Model model, HttpSession session) {
		String clientId = (String) session.getAttribute("clientId");
		// 세션에서 가져온 클라이언트 아이디로 장바구니 정보 조회
		List<CartsDTO> cartList = cartService.getCartById(clientId);

		model.addAttribute("cartList", cartList);

		return "cart";
	}

	@PostMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String addCart(@RequestParam("productId") String productId, Model model, HttpSession session) {
		String clientId = (String) session.getAttribute("clientId");
		
		if(clientId != null) {
			cartService.addCart(clientId,productId);
			return "cart";
		}else {
			// 로그인하지 않은 사용자인 경우 - 세션에 장바구니 정보 저장
            List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");
		}
		
		return cartService.addCart(session);
	}

	/*@GetMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public String updateCart() {
		return null;
	}*/

	@DeleteMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public String deleteCart(HttpSession session) {
		String clientId = (String) session.getAttribute("clientId");
		List<CartsDTO> cartList = cartService.getCartById(clientId);
		return cartService.deleteCart(cartList);
	}
	
	@PostMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
    public String pay(Model model,HttpSession session){
		String clientId = (String) session.getAttribute("clientId");
        cartService.pay(clientId); // 결제처리
        cartService.emptyCart(clientId); // 장바구니 비우기

        return "redirect:/main";
    }

}
