package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.CartsDTO;
import com.ounwan.entity.Carts;
import com.ounwan.repository.CartDAO;

@Service
public class CartService {

	@Autowired
	CartDAO cartDAO;
	@Autowired
	CoupungService coupungService;
	
	@Autowired
	HttpSession session;

	public List<Map<Object,Object>> getCartById(String clientId) {
		List<Map<Object,Object>> cartList = cartDAO.getCartById(clientId);
		
		//List<CartsDTO> cartList = changeDTOList(carts);

		/*
		 * System.out.println("cartList : " + cartList); for (CartsDTO cart : cartList)
		 * { cart.setCoupung(coupungService.getById(cart.getCoupungNumber())); }
		 */

		return cartList;
	}

	public int addToCart(CartsDTO cartsDTO) {
		 Carts cart = cartDAO.getQuantity(changeEntity(cartsDTO));
		 System.out.println("cart : " + cart);
		 
		if(cart != null) {
			System.out.println("quantity(NEW) : " + cartsDTO.getQuantity());
			System.out.println("quantity(old) : " + cart.getQuantity());
			cartsDTO.setQuantity(cartsDTO.getQuantity() + cart.getQuantity());
			System.out.println("quantity(update) : " + cartsDTO.getQuantity());
			cartsDTO.setCartNumber(cart.getCartNumber());
			return cartDAO.updateQuantity(changeEntity(cartsDTO));
		}
		return cartDAO.insertCart(changeEntity(cartsDTO));
	}
/*
	public boolean updateCart(String clientId, Integer coupungNumber, int quantity) {
		int result = cartDAO.updateCart(Carts.builder()
											.clientId(clientId)
											.quantity(quantity)
											.coupungNumber(coupungNumber)
											.build());
		System.out.println("result : " + result);
		return (result > 0) ? true : false;

	}
*/
	
	public boolean updateCart(CartsDTO cartsDTO) {
		int result = cartDAO.updateCart(changeEntity(cartsDTO));
		return (result > 0) ? true : false;
	}
	
	
	public boolean deleteCart(CartsDTO cartsDTO) {
		int result = cartDAO.deleteCart(changeEntity(cartsDTO));
		return (result > 0) ? true : false;
	}
	
	
	private CartsDTO changeDTO(Carts cart) {
		return CartsDTO.builder()
						.cartNumber(cart.getCartNumber())
						.coupungNumber(cart.getCoupungNumber())
						.clientId(cart.getClientId())
						.quantity(cart.getQuantity())
						.build();
	}
	
	private Carts changeEntity(CartsDTO cartsDTO) {
		return Carts.builder()
						.cartNumber(cartsDTO.getCartNumber())
						.coupungNumber(cartsDTO.getCoupungNumber())
						.clientId(cartsDTO.getClientId())
						.quantity(cartsDTO.getQuantity())
						.build();
	}

	
	

}
