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

import com.ounwan.dto.AdminDTO;
import com.ounwan.dto.AetaDTO;
import com.ounwan.dto.CoupungDTO;
import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.OrdersDTO;
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

	@GetMapping("/coupung/insert.do")
	public String insertProductView() {
		return "admin/productInsert";
	}

	@PostMapping("/coupung/insert.do")
	public @ResponseBody String insertProduct(@RequestBody CoupungDTO product) {
		int result = coupungService.insertProduct(product);
		return (result > 0) ? "success" : "fail";
	}
	
	@GetMapping("/coupung/update.do")
	public String getUpdateProducePage(@RequestParam int coupungNumber, Model model) {
		model.addAttribute("product", coupungService.getAdminProductDetail(coupungNumber));
		return "admin/productUpdate";
	}

	@PostMapping("/coupung/update.do")
	public @ResponseBody String updateProduct(@RequestParam Integer coupungNumber,
										@RequestParam String name,
							    		@RequestParam Integer price,
							    		@RequestParam Integer availableStock,
							    		@RequestParam(required=false) String[] addOptions,
							    		@RequestParam(required=false) String[] deleteOptions,
							    		@RequestParam String[] image,
							    		@RequestParam(required=false) String[] deleteImage,
							    		@RequestParam(required=false) String[] detailImages,
							    		@RequestParam(required=false) String[] deleteDetailImg) {
		boolean result = coupungService.updateProduct(CoupungDTO.builder()
														.coupungNumber(coupungNumber)
														.name(name)
														.price(price)
														.availableStock(availableStock)
														.build(), 
														addOptions, deleteOptions, image, deleteImage, detailImages, deleteDetailImg);
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

	@GetMapping("/danggun/AllList")
	public String danggunAllList(Model model) {
		model.addAttribute("list", danggunService.listAll());

		return "admin/danggunList";
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
		System.out.println(result);
		return result ? "success" : "fail";
	}

}