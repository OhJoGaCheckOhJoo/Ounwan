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

	public List<Map<String, Object>> getCartById(String clientId) {
		List<Map<String, Object>> cartList = cartDAO.getCartById(clientId);
		return cartList;
	}

	public List<Map<String, Object>> addToCart(CartsDTO cartsDTO, String clientId) {
		cartsDTO.setClientId(clientId);
		Carts cart = cartDAO.getQuantity(changeEntity(cartsDTO));
		int result = 0;
		if (cart != null) {
			result = cartDAO.updateQuantity(Carts.builder()	
												.cartNumber(cart.getCartNumber())
												.quantity(cartsDTO.getQuantity() + cart.getQuantity())
												.build());
		} else {
			result = cartDAO.insertCart(changeEntity(cartsDTO));
		}
		if (result > 0)
			return cartDAO.getCartById(clientId);
		return null;
	}
	


	public List<CartsDTO> addGuestCart(List<CartsDTO> cartList, CartsDTO cartsDTO) {
		List<CartsDTO> result = new ArrayList<>();
		if (cartList == null) {
			result.add(cartsDTO);
		} else {
			boolean check = false;
			for (CartsDTO cart : cartList) {
				if (cart.getCoupungNumber() == cartsDTO.getCoupungNumber() 
						&& cart.getCoupungOptionNumber() == cartsDTO.getCoupungOptionNumber()) {
					cart.setQuantity(cart.getQuantity() + cartsDTO.getQuantity());
					check = true;
				} 
				result.add(cart);
			}
			if (!check) result.add(cartsDTO);
		}
		return result;
	}

	public List<Map<String, Object>> updateCart(int coupungNumber, int coupungOptionNumber, int quantity, String clientId) {
		int result = cartDAO.updateCart(Carts.builder()
												.clientId(clientId)
												.coupungNumber(coupungNumber)
												.coupungOptionNumber(coupungOptionNumber)
												.quantity(quantity)
												.build());
		return (result > 0) ? cartDAO.getCartById(clientId) : null;
	}
	
	public List<CartsDTO> updateGuestCart(List<CartsDTO> cartList, int coupungNumber, int coupungOptionNumber,int quantity) {
		if (cartList != null) {
			for (CartsDTO cart : cartList) {
				if (cart.getCoupungNumber() == coupungNumber && cart.getCoupungOptionNumber() == coupungOptionNumber) {
					cart.setQuantity(quantity);
				}
			}
		}
		return cartList;
	}

	public List<Map<String, Object>> deleteCart(int coupungNumber, int optionNumber, String clientId) {
		int result = cartDAO.deleteCart(Carts.builder()
												.clientId(clientId)
												.coupungNumber(coupungNumber)
												.coupungOptionNumber(optionNumber)
												.build());
		return (result > 0) ? cartDAO.getCartById(clientId) : null;
	}
	
	public List<CartsDTO> deleteGuestCart(int coupungNumber, int optionNumber, List<CartsDTO> cartList) {
		for (CartsDTO cart : cartList) {
			if (cart.getCoupungNumber() == coupungNumber && cart.getCoupungOptionNumber() == optionNumber) {
				cartList.remove(cart);
				break;
			}
		}
		return cartList;
	}

	private CartsDTO changeDTO(Carts cart) {
		return CartsDTO.builder()
						.cartNumber(cart.getCartNumber())
						.coupungNumber(cart.getCoupungNumber())
						.clientId(cart.getClientId())
						.coupungOptionNumber(cart.getCoupungNumber())
						.quantity(cart.getQuantity())
						.build();
	}

	private Carts changeEntity(CartsDTO cartsDTO) {
		return Carts.builder()
					.cartNumber(cartsDTO.getCartNumber())
					.coupungNumber(cartsDTO.getCoupungNumber())
					.clientId(cartsDTO.getClientId())
					.coupungOptionNumber(cartsDTO.getCoupungOptionNumber())
					.quantity(cartsDTO.getQuantity())
					.build();
	}

}
