package com.ounwan.service;

import java.util.ArrayList;
import java.util.List;

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

	public List<CartsDTO> getCartById(String clientId) {
		List<Carts> carts = cartDAO.getCartById(clientId);
		List<CartsDTO> cartList = changeDTOList(carts);

		System.out.println("cartList : " + cartList);
		for (CartsDTO cart : cartList) {
			cart.setCoupung(coupungService.getById(cart.getCoupungNumber()));
		}

		return cartList;
	}

	public boolean addToCart(String clientId, String productId) {
		CartsDTO cart = changeDTO( cartDAO
				.getCartByClientAndProduct(Carts.builder()
												.clientId(clientId)
												.coupungNumber(Integer.parseInt(productId))
												.build()));
		if (cart != null) {
			// 이미 해당 상품이 장바구니에 있는 경우, 수량을 증가시킴
			int result = cartDAO.modifyQuantity(cart.getCartNumber());
			return (result > 0) ? true : false;
		} else {
			// 해당 상품이 장바구니에 없는 경우, 새로 추가
			// 해당 정보를 사용하여 Carts 객체를 생성하고 삽입
			int result = cartDAO.insertCart(
							Carts.builder()
							.clientId(clientId)
							.coupungNumber(Integer.parseInt(productId))
							.quantity(1) 
							.build());
			return (result > 0) ? true : false;
		}
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

}
