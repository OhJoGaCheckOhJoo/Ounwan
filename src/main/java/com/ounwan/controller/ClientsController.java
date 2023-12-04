package com.ounwan.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.ounwan.entity.Clients;
import com.ounwan.service.ClientsService;

//@RequestMapping("/clients")
@RestController
public class ClientsController {
	

	@Autowired
	ClientsService clientService;

	@GetMapping("/login.do")
	public ModelAndView loginGet() {
		//Map<String, ?> flashData = RequestContextUtils.getInputFlashMap(request);
//		if (flashData != null) {
//			for (String key : flashData.keySet()) {
//				model.addAttribute(key, flashData.get(key));
//			}
//		}
		ModelAndView v = new ModelAndView("login");
		System.out.println(123);
		return v;
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	public String loginPost(@RequestParam("clientId") String clientId, @RequestParam("password") String password,
			HttpServletRequest request, HttpSession session, RedirectAttributes attr) {

		Clients client = clientService.checkLogin(clientId, password);
//		session.setAttribute("clientId", clientId);
//		session.setAttribute("password", password);
		if (client == null) {
			attr.addFlashAttribute("message", "회원 정보가 없습니다.");
			return "fail!!"; 
		} else {
			return "success!!"; 
		}

	}

}
