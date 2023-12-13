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
		
		return cartDAO.insertCart(changeEntity(cartsDTO));
	}

	public boolean updateCart(String clientId, String coupungNumber, int quantity) {
		int result = cartDAO.updateCart(Carts.builder()
											.clientId(clientId)
											.quantity(quantity)
											.coupungNumber(Integer.parseInt(coupungNumber))
											.build());
		return (result > 0) ? true : false;

	}

	public boolean deleteCart(String clientId, String productId) {
		int result = cartDAO.deleteCart(Carts.builder()
								.clientId(clientId)
								.coupungNumber(Integer.parseInt(productId)) 																						
								.build());
		return (result > 0) ? true : false;
	}
	
	public List<CartsDTO> changeDTOList(List<Carts> cartList) {
		List<CartsDTO> result = new ArrayList<>();
		for (Carts cart : cartList) {
			result.add(changeDTO(cart));
		}
		return result;
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
