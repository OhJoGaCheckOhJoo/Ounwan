package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.ounwan.repository.ClientsDAO;

@Service
public class ClientsService {
	@Autowired
	ClientsDAO clientDAO;

	public String checkLogin(String id, String password) {  
		String dbpassword = clientDAO.checkLogin(id);
		if (dbpassword == null) {
			return "해당 아이디가 존재하지 않음!!"; 
		} else {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if(encoder.matches(password,dbpassword)) {
				return "로그인 성공!!";
			}else {
				return "비밀번호가 일치하지 않음";
			}
			 
		}
	}

}
