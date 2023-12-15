package com.ounwan.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.CartsDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.CoupungDTO;
import com.ounwan.service.CartService;

@Controller
@RequestMapping("/coupung")
public class CartController {

	@Autowired
	CartService cartService;

	// cart보기
/*	@GetMapping("/cart")
	public String showClientCart(Model model, HttpSession session) {
		Object obj = session.getAttribute("userInfo");
		List<Map<Object, Object>> cartList = new ArrayList<Map<Object, Object>>();

		if (obj == null) {
			session.getAttribute("cartList");
			System.out.println("비회원의 cartList : " + cartList);

		} else {
			cartList = cartService.getCartById(((ClientsDTO) obj).getClientId());
		}

		model.addAttribute("cartList", cartList);
		int total = 0;
		for (Map<Object, Object> map : cartList) {
			total += (Integer) map.get("price") * (Integer) map.get("QUANTITY");
		}
		model.addAttribute("total", total);

		return "coupung/cart";

	}
*/
	
	@GetMapping("/cart")
	public String showClientCart(Model model, HttpSession session) {
	    Object obj = session.getAttribute("userInfo");

	    List<Map<Object, Object>> UserCartList = new ArrayList<>();
	    List<CartsDTO> cartList = null;
	    if (obj == null) {
	    	cartList = (List<CartsDTO>) session.getAttribute("cartList");
	        System.out.println("비회원의 cartList : " + cartList);
	        model.addAttribute("GuestCartList", cartList); // 비회원의 장바구니 목록 모델에 추가
	    } else {
	        UserCartList = cartService.getCartById(((ClientsDTO) obj).getClientId());
	        model.addAttribute("clientId", ((ClientsDTO) obj).getClientId()); // 회원의 클라이언트 ID 모델에 추가
	    }
	    model.addAttribute("UserCartList", UserCartList); // 회원의 장바구니 목록 모델에 추가

	    int total = 0;
	    for (Map<Object, Object> map : UserCartList) {
	        total += (Integer) map.get("price") * (Integer) map.get("QUANTITY");
	    }
	    model.addAttribute("total", total);

	    return "coupung/cart";
	}

	
	
	
	// cart담기
	@PostMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String addCart(@RequestBody CartsDTO cartsDTO, HttpSession session) {

		Object obj = session.getAttribute("userInfo");
		List<CartsDTO> cartList = null;
		
		if (obj == null) {
			// 로그인 안한사람
			Object prevCartList = session.getAttribute("cartList");
			if (prevCartList == null) {
				// 처음으로 카드를 만듦
				cartList = new ArrayList<>();
				cartList.add(cartsDTO);
				System.out.println("세션에 cartList : "+cartList);
			} else {
				// 카트를 가지고있음
				cartList = (List<CartsDTO>) prevCartList;
				System.out.println("prevCartList : " + cartList);
				boolean updateOK = false;
				for (CartsDTO dto : cartList) {
					if (dto.getCoupungNumber() == cartsDTO.getCoupungNumber()) {
						System.out.println("getcoupungnum : " + dto.getCoupungNumber());
						dto.setQuantity(dto.getQuantity() + cartsDTO.getQuantity()); // 수정
						updateOK = true;
						break;
					}
				}
				if (updateOK == false)
					cartList.add(cartsDTO); // 추가
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

		System.out.println(coupungNumber + " : " + quantity);

		Object obj = session.getAttribute("userInfo");
		// 상품번호, 갯수, 고객id
		CartsDTO cartsDTO = CartsDTO.builder().coupungNumber(coupungNumber).quantity(quantity).build();

		if (obj == null) {
			// 로그인하지 않은 유저의 경우, 세션에서 update
			List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");

			if (cartList != null) {
				// productId에 해당하는 아이템을 찾아 수량을 변경하고 다시 세션에 설정
				for (CartsDTO cart : cartList) {
					if (cart.getCoupungNumber() == coupungNumber) {
						cart.setQuantity(quantity); // 새로운 수량으로 설정
						break;
					}
				}
				session.setAttribute("cartList", cartList);
			}

		} else {
			ClientsDTO client = (ClientsDTO) obj;
			cartsDTO.setClientId(client.getClientId());
			// 로그인한 유저의 경우, DB에서 update
			cartService.updateCart(cartsDTO);

		}
		return "cart";
	}

	@GetMapping(value = "/cartDelete", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String deleteCart(@RequestParam("coupungNumber") Integer coupungNumber, HttpSession session) {
		Object obj = session.getAttribute("userInfo");
		// 상품번호, 갯수, 고객id
		CartsDTO cartsDTO = CartsDTO.builder().coupungNumber(coupungNumber).build();
		if (obj == null) {
			// 로그인하지 않은 유저의 경우, 세션에서 삭제
			List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");

			if (cartList != null) {
				// productId에 해당하는 아이템을 세션에서 제거
				cartList.removeIf(cart -> ((CartsDTO) cart).getCoupungNumber() == coupungNumber);
				session.setAttribute("cartList", cartList);
			}
		} else {
			ClientsDTO client = (ClientsDTO) obj;
			cartsDTO.setClientId(client.getClientId());
			// 로그인한 유저의 경우, DB에서 update
			cartService.deleteCart(cartsDTO);
			;
		}
		return "cart";
	}

}
