package com.ounwan.controller;

import java.util.ArrayList;
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
		List<CartsDTO> cartList = new ArrayList<CartsDTO>();

		// 세션에서 가져온 클라이언트 아이디로 장바구니 정보 조회
		if (clientId != null) {
			cartList = cartService.getCartById(clientId);
		} else {

			cartList = (List<CartsDTO>) session.getAttribute("cartList");
		}

		model.addAttribute("cartList", cartList);

		return "cart";
	}

	@PostMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String addCart(@RequestParam("productId") String productId, Model model, HttpSession session) {
		String clientId = (String) session.getAttribute("clientId");

		if (clientId != null) {
			boolean result = cartService.addToCart(clientId, productId);
			return (result) ? "success" : "fail";
		} else {

			List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");
			cartList.add(
					CartsDTO.builder().clientId(null).coupungNumber(Integer.parseInt(productId)).quantity(1).build());
			session.setAttribute("cartList", cartList);
		}

		return "success";
	}

	@PostMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public String updateCart(@RequestParam("coupungNumber") String coupungNumber,
	                         @RequestParam("quantity") int quantity,
	                         HttpSession session) {
	    String clientId = (String) session.getAttribute("clientId");
	    
	    if (clientId != null) {
	        // 로그인한 유저의 경우, DB에서 update
	        cartService.updateCart(clientId, coupungNumber, quantity);
	        return "cart";
	    } else {
	        // 로그인하지 않은 유저의 경우, 세션에서 update
	        List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");

	        if (cartList != null) {
	            // productId에 해당하는 아이템을 찾아 수량을 변경하고 다시 세션에 설정
	            for (CartsDTO cart : cartList) {
	                if (cart.getCoupungNumber() == Integer.parseInt(coupungNumber)) {
	                    cart.setQuantity(quantity); // 새로운 수량으로 설정
	                    break;
	                }
	            }

	            session.setAttribute("cartList", cartList);
	        }
	    }
	    return "cart";
	}

	@DeleteMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public String deleteCart(@RequestParam("coupungNumber") String coupungNumber, HttpSession session) {
		String clientId = (String) session.getAttribute("clientId");

		if (clientId != null) {
			// 로그인한 유저의 경우, DB에서 삭제
			cartService.deleteCart(clientId, coupungNumber);
			return "cart";
		} else {
			// 로그인하지 않은 유저의 경우, 세션에서 삭제
			List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");

			if (cartList != null) {
				// productId에 해당하는 아이템을 세션에서 제거
				cartList.removeIf(cart -> cart.getCoupungNumber() == Integer.parseInt(coupungNumber));
				session.setAttribute("cartList", cartList);
			}
		}

		return "cart";
	}

}
