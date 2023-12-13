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
import com.ounwan.service.CartService;

@Controller
@RequestMapping("/coupung")
public class CartController {

	@Autowired
	CartService cartService;

	 //cart보기 
	@GetMapping("/cart")
	public String showClientCart(Model model, HttpSession session) {
		ClientsDTO loginUser = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = loginUser.getClientId();
		System.out.println("cliendId : " + loginUser.getClientId());
		List<Map<Object,Object>> cartList = new ArrayList<Map<Object,Object>>();

		// 세션에서 가져온 클라이언트 아이디로 장바구니 정보 조회
		if (clientId != null) {
			cartList = cartService.getCartById(clientId);
		} else {

			cartList = (List<Map<Object,Object>>) session.getAttribute("cartList");
		}

		model.addAttribute("cartList", cartList);
		int total = 0;
        for(Map<Object,Object> map:cartList) {
        	total += (Integer)map.get("price") *  (Integer)map.get("QUANTITY");  	
        }
        model.addAttribute("total", total);

		return "coupung/cart";
		
	}
	
	
    //cart담기 
	@PostMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String addCart(@RequestBody String productId, Integer quantity,  HttpSession session) {
	    
		Object obj = session.getAttribute("userInfo");
		List<CartsDTO> cartlist = null;
		//상품번호, 갯수, 고객id
		CartsDTO cartsDTO = CartsDTO.builder()
                .coupungNumber(Integer.parseInt(productId))
                .quantity(quantity)
                .build();
		if(obj==null) {
			//로그인 안한사람 
			Object prevCartList = session.getAttribute("cartList");
			if(prevCartList==null) {
				//처음으로 카드를 만듦
				cartlist = new ArrayList<>();
				cartlist.add(cartsDTO);
			}else {
				//카트를 가지고있음 
				cartlist = (List<CartsDTO>)prevCartList;
				boolean updateOK = false;
				for(CartsDTO dto:cartlist) {
					if(dto.getCoupungNumber().equals(productId)) {
						dto.setQuantity(dto.getQuantity()+quantity); //수정 
						updateOK = true;
						break;
					}
				}
				if(updateOK==false) cartlist.add(cartsDTO); //추가 
			}
			
			session.setAttribute("cartList", cartlist);
		}else {
			ClientsDTO client = (ClientsDTO)obj;
			cartsDTO.setClientId(client.getClientId());
			cartService.addToCart(cartsDTO);		
		}
		return "success";
		
		
		
		/*String clientId = (String) session.getAttribute("clientId");
	    List<Map<Object,Object>> cartList = (List<Map<Object,Object>>) session.getAttribute("cartList");
	    
	    if (clientId != null) {
	        boolean result = cartService.addToCart(clientId, productId);
	        return result ? "success" : "fail";
	    } else {
	        if (cartList == null) {
	            cartList = new ArrayList<>();
	        }
	        cartList.add(
	                (Map<Object, Object>) CartsDTO.builder()
	                        .clientId(null)
	                        .coupungNumber(Integer.parseInt(productId))
	                        .quantity(1)
	                        .build());
	        
	        session.setAttribute("cartList", cartList);
	        return "success";*/
	    }
	
	
	
	

	@PutMapping(value = "/cart", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String updateCart(@RequestParam("coupungNumber") String coupungNumber,
	                         @RequestParam("quantity") int quantity,
	                         HttpSession session) {
		ClientsDTO loginUser = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = loginUser.getClientId();
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
	public @ResponseBody String deleteCart(@RequestParam("coupungNumber") String coupungNumber, HttpSession session) {
		ClientsDTO loginUser = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = loginUser.getClientId();
		if (clientId != null) {
			// 로그인한 유저의 경우, DB에서 삭제
			cartService.deleteCart(clientId, coupungNumber);
			return "cart";
		} else {
			// 로그인하지 않은 유저의 경우, 세션에서 삭제
			List<CartsDTO> cartList = (List<CartsDTO>) session.getAttribute("cartList");

			if (cartList != null) {
				// productId에 해당하는 아이템을 세션에서 제거
				cartList.removeIf(cart -> ((CartsDTO) cart).getCoupungNumber() == Integer.parseInt(coupungNumber));
				session.setAttribute("cartList", cartList);
			}
		}

		return "cart";
	}
	
	
}
