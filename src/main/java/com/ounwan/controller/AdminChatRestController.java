package com.ounwan.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ounwan.service.AdminChatService;

@RequestMapping("/admin")
@RestController
public class AdminChatRestController {	
	@Autowired
	AdminChatService adminChatService;
	
//	@RequestMapping("/chat/list")
//	public List<SomsomiChatMessageDTO> selectDanggunChatList(@RequestParam(name = "roomId") String roomId, @RequestParam(name = "clientId") String clientId, Model model) {
//		List<SomsomiChatMessageDTO> result = adminChatService.selectSomsomiChatList(clientId, roomId);
//		
//		
//		return result;
//	}
}
