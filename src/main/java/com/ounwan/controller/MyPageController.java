package com.ounwan.controller;

import javax.servlet.http.HttpSession;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

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
		return "myPage/myPage";
	}
	/*
	 * @RequestMapping(value = "/checkPwd", method = RequestMethod.POST, produces =
	 * "text/plain;charset=UTF-8") public @ResponseBody String checkPwd(@RequestBody
	 * ClientsDTO client, HttpSession session) { System.out.println("내가 입력 비번 : " +
	 * client.getPassword()); ClientsDTO loginUser =
	 * clientService.checkLogin(client.getClientId(), client.getPassword());
	 * 
	 * System.out.println(loginUser); if (loginUser != null) { return "success"; }
	 * return "fail"; }
	 */

	@GetMapping(value = "/checkPwd")
	public String checkPwd(HttpSession session) {
		String clientId = "jj1234";
		session.setAttribute("testUser", clientId);
		return "myPage/checkPwd";
	}

	@RequestMapping(value = "/checkPwd", method = RequestMethod.POST, produces = "text/plain;charset=UTF-8")
	public @ResponseBody String checkPwd(String enteredPassword, HttpSession session) {
		System.out.println("!!!enteredPassword : " + enteredPassword);

		String clientId = (String) session.getAttribute("testUser");
		String storedPassword = myPageService.getPwdById(clientId); // DB에서 해당 클라이언트의 암호화된 비밀번호를 가져옵니다.

		System.out.println("!!!storedPassword : " + storedPassword);

		if (storedPassword != null && BCrypt.checkpw(enteredPassword, storedPassword)) {
			return "success";
		}
		return "fail";
	}

	/*
	 * @RequestMapping(value = "/modifyUserInfo", method = RequestMethod.GET,
	 * produces = "text/plain;charset=UTF-8") public String
	 * showUserInfo(@RequestBody ClientsDTO client, Model model) { String userInfo =
	 * myPageService.getUserInfo(client); model.addAttribute(userInfo); return
	 * "/myPage/checkPwd";
	 * 
	 * }
	 */
	
	@RequestMapping(value = "/modifyUserInfo", method = RequestMethod.GET, produces = "text/plain;charset=UTF-8")
	public String showUserInfo(HttpSession session, Model model) {
	
		String clientId = (String) session.getAttribute("testUser");
		ClientsDTO userInfo = myPageService.getUserInfo(clientId);
		System.out.println("!!!userInfo : " + userInfo);
		model.addAttribute("userInfo", userInfo);
		return "/myPage/modifyUserInfo"; // 회원정보 수정 페이지의 뷰 이름
	}


	@RequestMapping(value = "/modifyUserInfo/pwd", method = RequestMethod.POST, consumes = "application/json")
	public @ResponseBody String modifyPwd(@RequestBody ClientsDTO clientsDTO, HttpSession session) throws Exception {
		System.out.println("!!!!clientsDTO : " + clientsDTO.getPassword());
		int result = myPageService.modifyPwd(clientsDTO);
		System.out.println("!!result : " + result);
		if (result > 0) {
			System.out.println("YESSSSSS");
		} else {
			System.out.println("NOOOOOOOOO");
		}
		return "success";
	}

	@RequestMapping(value = "/modifyUserInfo", method = RequestMethod.POST, consumes = "application/json", produces = "text/plain;charset=UTF-8")
	public @ResponseBody String modifyUserInfo(@RequestBody ClientsDTO clientsDTO) {
		myPageService.modifyUserInfo(clientsDTO);
		return "success";

	}
	
	@PostMapping(value="/updateImg")
	public @ResponseBody String updateImage(@RequestParam("image") MultipartFile image,  @RequestParam("clientId") String clientId) {
	    System.out.println("!!!!formdata : " + image );
	    System.out.println("@@@@formdata : " + clientId );
	    
		String imgString = myPageService.updateImage(image, clientId);
	    return imgString;
	}
	
	
}
