package com.ounwan.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.GuestsDTO;
import com.ounwan.service.GuestService;

@Controller
public class GuestController {
	
	@Autowired
	GuestService guestService;
	
	@GetMapping("/guest")
	public String getGuestPage() {
		return "guest";
	}
	
	@PostMapping("/guest")
	public @ResponseBody String setGuestInfo (@RequestBody GuestsDTO guest, HttpSession session) {
		boolean result = guestService.addGuestInfo(guest);
		
		if (result)
			session.setAttribute("guest", guest);
		
		return (result) ? "success" : "fail"; 
	}
}
