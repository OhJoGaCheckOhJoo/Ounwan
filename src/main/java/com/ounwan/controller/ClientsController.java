package com.ounwan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.ClientsService;

@RestController
@RequestMapping("/client")
public class ClientsController {
	
	@Autowired
	ClientsService clientsService;
	
	@SuppressWarnings("static-access")
	@GetMapping(value = "/findId", consumes = "text/plain;charset=UTF-8", produces = "application/json")
	public String findId(@RequestParam("name") String name, @RequestParam("email") String email, Model model) {
		ClientsDTO clientsDTO = new ClientsDTO().builder().name(name).email(email).build();
		String id = clientsService.findClientId(clientsDTO);
		return id;
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping("/findPassword")
	public String findPassword(@RequestParam("id") String id, @RequestParam("email") String email) {
		ClientsDTO clientsDTO = new ClientsDTO().builder().clientId(id).email(email).build();
		System.out.println(clientsDTO.toString());
		String result = clientsService.findPassword(clientsDTO);
		return result;
	}
	
}
