package com.ounwan.controller;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.ClientsService;
import com.ounwan.service.MyPageService;

@RequestMapping("/myPage")
@Controller
public class MyPageController {

	@Autowired
	MyPageService myPageService;

	@Autowired
	ClientsService clientService;
	
	@RequestMapping(method = RequestMethod.GET)
	public String myPageMain() {
		return "/myPage/myPage";
	}
/*
	@RequestMapping(value = "/checkPwd", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
    public @ResponseBody String checkPwd(@RequestBody ClientsDTO client, HttpSession session) {
        System.out.println("내가 입력 비번 : " + client.getPassword());
        ClientsDTO loginUser = clientService.checkLogin(client.getClientId(), client.getPassword());
        
        System.out.println(loginUser);
        if (loginUser != null) {
            return "success";
        }
        return "fail";
    }
*/    
	@RequestMapping(value = "/checkPwd", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String checkPwd(@RequestBody String enteredPassword, HttpSession session) {
	    String clientId = (String) session.getAttribute("jj1234");
	    String storedPassword = myPageService.getPasswordById(clientId); // DB에서 해당 클라이언트의 비밀번호를 가져오는 메서드를 가정하였습니다.

	    if (storedPassword != null && BCrypt.checkpw(enteredPassword, storedPassword)) {
	        return "success";
	    }
	    return "fail";
	}
/*
	@RequestMapping(value = "/modifyUserInfo", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String showUserInfo(@RequestBody ClientsDTO client, Model model) {
		String userInfo = myPageService.getUserInfo(client);
		model.addAttribute(userInfo);
		return "/myPage/checkPwd";

	}
*/	
	@RequestMapping(value = "/modifyUserInfo", method = RequestMethod.GET)
	public String showUserInfo(HttpSession session, Model model) {
	    String clientId = (String) session.getAttribute("jj1234");
	    model.addAttribute("clientId", clientId);
	    return "/myPage/checkPwd"; // 회원정보 수정 페이지의 뷰 이름
	}

	@RequestMapping(value = "/modifyUserInfo/pwd", method = RequestMethod.POST, consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public String modifyPwd(@RequestBody ClientsDTO clientsDTO, String password, HttpSession session)
			throws Exception {
		int result = myPageService.modifyPwd(clientsDTO);
		if(result > 0) {
			System.out.println("YESSSSSS");
		} else {
			System.out.println("NOOOOOOOOO");
		}
		return "success";
	} 
	

	@RequestMapping(value = "/modifyUserInfo", method = RequestMethod.POST, consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public String modifyUserInfo(@RequestBody ClientsDTO clientsDTO) {
		myPageService.modifyUserInfo(clientsDTO);
		return "success";

	}

}
