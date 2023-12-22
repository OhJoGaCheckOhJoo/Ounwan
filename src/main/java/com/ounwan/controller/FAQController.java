package com.ounwan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.ounwan.service.FAQService;

@Controller
public class FAQController {
	
	@Autowired
	FAQService faqService;
	
	@RequestMapping("/faq")
	public String getFAQPage(Model model) {
		model.addAttribute("pages", faqService.countFAQList());
		return "faq/faq";
	}
	
	@RequestMapping("/getFAQList")
	public String getFAQList(@RequestParam int category, @RequestParam int offset, Model model) {
		model.addAttribute("faqList", faqService.getFAQList(category, offset));
		return "faq/faqList";
	}
}
