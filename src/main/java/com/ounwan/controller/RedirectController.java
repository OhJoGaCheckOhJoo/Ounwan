package com.ounwan.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class RedirectController {

	@GetMapping("/unsellableProduct")
	public String getUnsellableProductPage() {
		return "unsellableProduct";
	}
	
}
