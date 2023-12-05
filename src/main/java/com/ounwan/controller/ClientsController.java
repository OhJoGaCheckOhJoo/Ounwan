package com.ounwan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.ClientsService;

@RestController
@RequestMapping("/clients")
public class ClientsController {
	
	@Autowired
	ClientsService clientsService;
	
	@PostMapping(value = "/signUp", consumes= "application/json", produces="text/plain;charset=utf-8")
	public String createAccount(@RequestBody ClientsDTO client) {
		System.out.println(client);
		int result = clientsService.createAccount(client);
		if(result > 0) {
			System.out.println("YESSSSSS");
		} else {
			System.out.println("NOOOOOOOOO");
		}
		return "success";
	}

}
