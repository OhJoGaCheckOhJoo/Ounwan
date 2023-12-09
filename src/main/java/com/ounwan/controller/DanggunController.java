package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.DanggunDTO;
import com.ounwan.entity.Danggun;
import com.ounwan.service.DanggunService;

@RequestMapping("/danggun")
@Controller
public class DanggunController {

	@Autowired
	DanggunService danggunService;

	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainGet(HttpSession session, Model model) {
		session.getAttribute("clientId");
		List<DanggunDTO> list = danggunService.listAll();
		model.addAttribute("list", list);
		return "danggunMain";
	}

	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public @ResponseBody List<DanggunDTO> searchProduct(@RequestParam ("searchInput") String searchInput, HttpSession session) {	
		List<DanggunDTO> result = danggunService.searchProduct(searchInput);
		return result;
	}



}
