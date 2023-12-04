package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.entity.Clients;
import com.ounwan.repository.ClientsDAO;

@Service
public class ClientsService {
	@Autowired
	ClientsDAO clientDAO;

	public Clients checkLogin(String id, String password) {
		return clientDAO.checkLogin(id,password);
	}

}
