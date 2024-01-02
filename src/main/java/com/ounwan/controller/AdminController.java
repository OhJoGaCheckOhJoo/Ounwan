package com.ounwan.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ounwan.dto.AdminDTO;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.CoupungDTO;
import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.dto.PaginatingDTO;
import com.ounwan.service.AdminService;
import com.ounwan.service.CommunityService;
import com.ounwan.service.CoupungService;
import com.ounwan.service.DanggunService;
import com.ounwan.service.OrderService;

@Controller
@RequestMapping("/admin")
public class AdminController {

	@Autowired
	AdminService adminService;

	@Autowired
	CoupungService coupungService;

	@Autowired
	OrderService orderService;

	@Autowired
	DanggunService danggunService;

	@Autowired
	CommunityService communityService;

	@GetMapping("/main.do")
	public String getMainPage(HttpSession session) {
		System.out.println((AdminDTO) session.getAttribute("admin"));
		if (session.getAttribute("admin") == null)
			return "admin/login";
		return "admin/home";
	}

	@GetMapping("/login.do")
	public String getLoginPage() {
		return "admin/login";
	}

	@PostMapping("login.do")
	public @ResponseBody String checkAuthorization(@RequestBody AdminDTO adminDTO, HttpSession session) {
		AdminDTO result = adminService.checkAuthorization(adminDTO);
		if (result != null) {
			session.setAttribute("admin", result);
			return "success";
		}
		return "fail";
	}
	
	@GetMapping("/coupung/product.do")
	public String getProductPage(@RequestParam int offset,
	@RequestParam String searchOption,
	@RequestParam String searchValue,
	@RequestParam String sortOption,
	Model model) {
	model.addAttribute("productList", coupungService.getAdminProductList(offset, searchOption, searchValue, sortOption));
	model.addAttribute("pages", coupungService.getProductCount(searchOption, searchValue));
	model.addAttribute("offset", offset / 20);
	model.addAttribute("searchOption", searchOption);
	model.addAttribute("searchValue", searchValue);
	model.addAttribute("sortOption", sortOption);
	return "admin/product";
	}
	
	@GetMapping("/coupung/searchProduct")
	public String searchProduct(@RequestParam String searchOption, @RequestParam String searchValue) {

		return "admin/product";
	}

	@GetMapping("/ounwangram/reports")
	public String getGramReportBoards(@RequestParam int offset, Model model) {
		model.addAttribute("boards", communityService.getReportGramBoard(offset));
		return "admin/gramReportBoards";
	}

	@PostMapping("/coupung/addProduct")
	public String addProduct(@RequestPart MultipartFile mainImage,
			@RequestPart(required = false) MultipartFile[] subImage,
			@RequestPart(required = false) MultipartFile[] explanationImg, String name, int price) {
		return null;
	}

	@GetMapping("/coupung/sortProduct")
	public String sortProduct(@RequestParam String sort, @RequestParam String searchOption,
			@RequestParam String searchValue) {

		return "admin/product";
	}

	@GetMapping("/coupung/insert.do")
	public String insertProductView() {
		return "admin/productDetail";
	}

	@PostMapping("/coupung/insert.do")
	public @ResponseBody String insertProduct(@RequestBody CoupungDTO product) {
		int result = coupungService.insertProduct(product);
		return (result > 0) ? "success" : "fail";
	}

	@PostMapping("/coupung/update.do")
	public @ResponseBody String updateProduct(@RequestBody CoupungDTO product) {
		boolean result = coupungService.updateProduct(product);
		return (result) ? "success" : "fail";
	}

	@PostMapping("/coupung/delete.do")
	public @ResponseBody String deleteProduct(@RequestBody int coupungNumber) {
		boolean result = coupungService.deleteProduct(coupungNumber);
		return (result) ? "success" : "fail";
	}

	@GetMapping("/order/orderList.do")
	public @ResponseBody List<OrdersDTO> getOrderList() {
		return orderService.getAdminOrderList();
	}

	@PostMapping("/order/tradeStep.do")
	public @ResponseBody String updateTradeStatus(@RequestBody OrdersDTO order) {
		boolean result = orderService.updateTradeStatus(order);
		return (result) ? "success" : "fail";
	}

	@GetMapping("/danggun/danggunBoard")
	public String danggunBoard() {		
		return "admin/danggunBoard";
	}
	@GetMapping("/danggun/AllList")
	public String danggunAllList(Model model,
			@RequestParam(value = "inputValue", defaultValue = "%") String name,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		
		model.addAttribute("danggun", danggunService.pagenatedList(page,name));
		model.addAttribute("paginating", danggunService.getPages(page,name));
		System.out.println();
		
		return "admin/danggunList";
	}
	@GetMapping("/danggun/danggunDetail")
	public String danggunDetailModel (
			Model model,
			@RequestParam Integer danggunNumber) {
			danggunService.danggunAdminDetail(danggunNumber);
	
		return "admin/danggunDetail";
	}
	
		
	

	@GetMapping("/danggun/report")
	public String getDanggunReport(Model model) {
		List<DanggunDTO> result = danggunService.getDanggunReportList();
		model.addAttribute("danggun", result);
		return "admin/danggunReport";
	}

	@PostMapping("/danggun/restore")
	public @ResponseBody String restoreDanggun(@RequestParam("danggunNumber") Integer danggunNumber) {
		boolean result = danggunService.restoreDanggun(danggunNumber);
		return result ? "success" : "fail";
	}

	@GetMapping("/aeta/report")
	public String getAetaReport(Model model) {
		List<AetaDTO> result = communityService.getAetaReportList();
		model.addAttribute("aeta", result);
		return "admin/aetaReport";
	}

	@PostMapping("/aeta/restore")
	public @ResponseBody String restoreAeta(@RequestParam("aetaNumber") Integer aetaNumber) {
		boolean result = communityService.restoreAeta(aetaNumber);
		return result ? "success" : "fail";
	}

	@GetMapping("/aeta/aetaBoard")
	public String aetaBoard() {		
		return "admin/aetaBoard";
	}
	
	@GetMapping("/aeta/AllList")
	public String aetaAllList(@RequestParam(value = "inputValue", defaultValue = "%") String inputValue,
			@RequestParam(value = "selectedOption", defaultValue = "%") String selectedOption, Model model,
			@RequestParam(value = "page", required = false, defaultValue = "1") int page) {
		List<AetaDTO> aetaList = communityService.aetaList(page, inputValue, selectedOption);
		PaginatingDTO paginating = communityService.getPages(page, inputValue, selectedOption);

		model.addAttribute("aetaList", aetaList);
		model.addAttribute("paginating", paginating);
		model.addAttribute("inputValue", inputValue);
		model.addAttribute("selectedOption", selectedOption);
		return "admin/aetaList";
	}

	@GetMapping("/aeta/aetaPost")
	public String aetaReadPost(@RequestParam Integer aetaNumber, Model model) {
		model.addAttribute("aetaPost", communityService.aetaReadPost(aetaNumber));		
		model.addAttribute("aetaComments", communityService.aetaReadComments(aetaNumber));
		model.addAttribute("aetaCountLikes", communityService.aetaCountLikes(aetaNumber));
		model.addAttribute("aetaCountComments", communityService.aetaCountComments(aetaNumber));
		
		return "/admin/aetaPost";
	}
	
}
