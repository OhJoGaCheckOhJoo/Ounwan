package com.ounwan.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
		return "guest";
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
	
	// 비회원 정보조회 페이지 요청 컨트롤러
//	@GetMapping("/checkInfo")
//	public String getInfoPage() {
//		return "guest/checkInfo";
//	}
	
	@PostMapping("/checkInfo")
	public @ResponseBody OrdersDTO checkInfo(@RequestBody GuestsDTO guest) {
		System.out.println("eeee");
		return guestService.getGuestInfo(guest);
	}
}
