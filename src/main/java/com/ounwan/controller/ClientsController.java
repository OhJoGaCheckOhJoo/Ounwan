package com.ounwan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.ClientsService;

@RestController
@RequestMapping("/clients")
public class ClientsController {
	
	@Autowired
	ClientsService clientsService;
	
	@GetMapping("/login")
	public String login() {
		return "login";
	}
	
	@SuppressWarnings("static-access")
	@GetMapping(value = "/findId", consumes = "text/plain;charset=UTF-8", produces = "application/json")
	public String findId(@RequestParam("name") String name, @RequestParam("email") String email) {
		System.out.println(name + " : " + email);
		ClientsDTO clientsDTO = new ClientsDTO().builder().name(name).email(email).build();
		String id = clientsService.findClientId(clientsDTO);
		return id;
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping(value = "/findPassword", consumes = "text/plain;charset=UTF-8", produces = "application/json")
	public String findPassword(@RequestParam("clientId") String clientId, 
							@RequestParam("email") String email) {
		ClientsDTO clientsDTO = new ClientsDTO().builder().clientId(clientId).email(email).build();
		String result = clientsService.findPassword(clientsDTO);
		return result;
	}
	
	@SuppressWarnings("static-access")
	@RequestMapping("/withdrawal")
	public String withdrawal(@RequestParam("clientId") String clientId, @RequestParam("privacyTerms") int privacyTerms) {
		ClientsDTO clientsDTO = new ClientsDTO().builder().clientId(clientId).privacyTerms(privacyTerms).build();
		String result = clientsService.withdrawalClient(clientsDTO);
		return result;
	}
	
}
