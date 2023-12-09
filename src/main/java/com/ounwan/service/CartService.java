package com.ounwan.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.CartsDTO;
import com.ounwan.repository.ClientsDAO;

@Service
public class CartService {

	@Autowired
	ClientsDAO clientsDAO;

	public List<CartsDTO> getCartById(String clientId) {
		return null;
	}

	public String addCart(HttpSession session) {
		// 세션 정보의 유무에 따른 회원/비회원 로직 구현
		return null;
	}

	public String deleteCart(List<CartsDTO> cartList) {
		// TODO Auto-generated method stub
		return null;
	}

	public void pay(String clientId) {
		// TODO Auto-generated method stub
		
	}

	public void emptyCart(String clientId) {
		// TODO Auto-generated method stub
		
	}

	


	
}
