package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.ounwan.repository.ClientsDAO;

@Service
public class ClientsService {
	@Autowired
	ClientsDAO clientDAO;

	public boolean checkLogin(String id, String password) {  
		String dbpassword = clientDAO.checkLogin(id);
		if (dbpassword == null) {
			return false;
		} else {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if(encoder.matches(password,dbpassword)) {
				return true;
			}else {
				return false;
			}
			 
		}
	}

}
