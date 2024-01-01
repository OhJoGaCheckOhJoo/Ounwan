package com.ounwan.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.GuestsDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.service.GuestService;

@Controller
@RequestMapping("/guest")
public class GuestController {
	
	@Autowired
	GuestService guestService;
	
	@GetMapping()
	public String getGuestPage() {
		return "/guest/guestCheck";
	}
	
	@PostMapping()
	public @ResponseBody String setGuestInfo (@RequestBody GuestsDTO guest, HttpSession session) {
		GuestsDTO result = guestService.addGuestInfo(guest);
		
		if (result != null) {
			session.setAttribute("guest", result);
			return "success";
		}
		return "fail";
	}
		
	@PostMapping("/checkInfo")
	public String checkInfo(@RequestBody GuestsDTO guest, Model model) {
		System.out.println("eeee");
		OrdersDTO order = guestService.getGuestInfo(guest);
		model.addAttribute("orderList", order);
		return "/guest/guestOrderListModal";
	}
}
