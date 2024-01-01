package com.ounwan.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.CoupungDTO;
import com.ounwan.dto.GuestsDTO;
import com.ounwan.dto.OrdersDTO;
import com.ounwan.service.CoupungService;
import com.ounwan.service.OrderService;
import com.siot.IamportRestClient.IamportClient;
import com.siot.IamportRestClient.exception.IamportResponseException;
import com.siot.IamportRestClient.response.IamportResponse;
import com.siot.IamportRestClient.response.Payment;

@Controller
@RequestMapping("/coupung")
public class CoupungController {
	
	@Autowired
	CoupungService coupungService;
	@Autowired
	OrderService orderService;
	
	private static final String IAMPORT_REST_APIKEY = "00";
    private static final String IAMPORT_SECRET = "00";
    private IamportClient api = new IamportClient(IAMPORT_REST_APIKEY, IAMPORT_SECRET);
    
	@GetMapping("/products")
	public String getProductMain (@RequestParam(defaultValue = "0") String categoryNum, Model model) {
		List<CoupungDTO> productList = coupungService.getProductList(Integer.parseInt(categoryNum));
		model.addAttribute("productList", productList);
		return "coupung/products";
	}
	
	@GetMapping("/product/top-five")
	public @ResponseBody List<CoupungDTO> getTopFive() {
		return coupungService.getTopFive();
	}
	
	@GetMapping("/product/category")
	public @ResponseBody ResponseEntity<?> getProductsByCategory(@RequestParam String categoryNum) {
		List<CoupungDTO> productList = coupungService.getProductList(Integer.parseInt(categoryNum));
		return ResponseEntity.ok(productList);
	}
	
	@GetMapping("/product/name")
	public @ResponseBody ResponseEntity<?> findByProductName(@RequestParam String text) {
		if(text.length() == 0) return ResponseEntity.ok(null);
		List<CoupungDTO> productList = coupungService.findByProductName(text);
		return ResponseEntity.ok(productList);
	}
	
	
	@GetMapping("/product/detail")
	public String getDetailString (@RequestParam String coupungId, Model model) {
		CoupungDTO coupung = coupungService.getProductDetail(Integer.parseInt(coupungId), 0, 0);
		model.addAttribute("detail", coupung);
		
		List<Map<String, Object>> reviewList = coupungService.getReviewList(Integer.parseInt(coupungId));
		List<Integer> scoreList = coupungService.getScoreList(Integer.parseInt(coupungId));
		model.addAttribute("reviewList", reviewList);
		model.addAttribute("scoreList", scoreList);
		return "/coupung/detail";
	}
	
	@GetMapping("/hot-deal")
	public String getHotDeal(HttpSession session, Model model) {
		String clientId = ((ClientsDTO) session.getAttribute("userInfo")).getClientId();
		boolean history = coupungService.checkOrderHistory(clientId);
		List<CoupungDTO> productList = coupungService.getHotDealProductList();
		
		model.addAttribute("history", history);
		model.addAttribute("products", productList);
		
		return "/coupung/hot-deal";
	}
	
	@GetMapping("/hot-deal/detail")
	public String getHotDealDetail(@RequestParam String coupungId, Model model) {
		CoupungDTO coupung = coupungService.getProductDetail(Integer.parseInt(coupungId), 0, 0);
		
		model.addAttribute("detail", coupung);
		
 		return "/coupung/hot-deal/detail";
	}
	
	@GetMapping("/order") 
	public String getOrderPage(@RequestParam List<Integer> productList
								, @RequestParam List<Integer> optionList
								, @RequestParam List<Integer> quantityList
								, Model model) {
		List<CoupungDTO> result = new ArrayList<>();
		for (int i = 0; i < productList.size(); i++) {
			CoupungDTO order = coupungService.getProductDetail(productList.get(i), optionList.get(i), quantityList.get(i));
			result.add(order);
		}
		model.addAttribute("products", result);
		
		return "coupung/order";
	}

	@PostMapping("/order")
	public @ResponseBody String setOrder(@RequestBody OrdersDTO order, HttpSession session) {
		ClientsDTO client = (ClientsDTO) session.getAttribute("userInfo");
		GuestsDTO guest = (GuestsDTO) session.getAttribute("guest");

		boolean result = orderService.setOrder(order, client, guest, session);
		
		return (result) ? "success" : "fail";
	}
	
	@GetMapping("/price")
	public @ResponseBody int getPrice(@RequestParam List<String> coupungNumbers, @RequestParam List<String> quantities) {
		return coupungService.getPrice(coupungNumbers, quantities);
	}
	
	@GetMapping("/order/complete")
	public String getOrderCompletePage(HttpSession session, Model model) {
		GuestsDTO guest = (GuestsDTO) session.getAttribute("guest");
		ClientsDTO client = (ClientsDTO) session.getAttribute("userInfo");
		String orderNumber = orderService.getOrderNumber(client, guest);
		model.addAttribute("orderNumber", orderNumber);
		return "coupung/complete";
	}
	
	@RequestMapping("/orderCheck")
	public @ResponseBody IamportResponse<Payment> paymentByImpUid(@RequestParam(value= "imp_uid") String imp_uid) 
																			throws IamportResponseException, IOException {	
		return api.paymentByImpUid(imp_uid);
	}
}
