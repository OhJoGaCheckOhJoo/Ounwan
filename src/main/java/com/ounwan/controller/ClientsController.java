package com.ounwan.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.ounwan.entity.Clients;
import com.ounwan.service.ClientsService;

//@RequestMapping("/clients")
@RestController
public class ClientsController {
	

	@Autowired
	ClientsService clientService;

	@GetMapping("/login")
	public ModelAndView loginGet() {
		ModelAndView v = new ModelAndView("login");
		return v;
	}

	@RequestMapping(value = "/login", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public String loginPost(String clientId, String password,
			HttpServletRequest request, RedirectAttributes attr) {
		System.out.println("clientId " + clientId);
		System.out.println("password " + password);
		Clients client = clientService.checkLogin(clientId, password);
		if (client == null) {
			attr.addFlashAttribute("message", "회원 정보가 없습니다.");
			return "실패!!"; 
		} else {
			return "성공!!"; 
		}

	}

}
