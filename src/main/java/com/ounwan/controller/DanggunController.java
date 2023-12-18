package com.ounwan.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestPart;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.dto.DanggunDTO;
import com.ounwan.dto.ProductImagesDTO;
import com.ounwan.service.DanggunService;
import com.ounwan.service.ProductImagesService;
import com.ounwan.service.TradeHistoryService;
import com.ounwan.service.WishListsService;

@RequestMapping("/danggun")
@Controller
public class DanggunController {
	@Autowired
	DanggunService danggunService;

	@Autowired
	ProductImagesService productImageService;

	@Autowired
	TradeHistoryService tradeHistoryService;

	@Autowired
	WishListsService wishListsService;

//	당군 메인 페이지로 이동
	@RequestMapping(value = "/main", method = RequestMethod.GET)
	public String mainGet(HttpSession session, Model model) {

		List<DanggunDTO> list = danggunService.listAll();

		for (DanggunDTO danggun : list) {
			ProductImagesDTO image = productImageService.selectAllImages(danggun.getDanggunNumber());
			System.out.println("d : " + danggun.getDanggunNumber());
			danggun.setUrl(image.getUrl());
		}
		System.out.println("list : " + list);
		model.addAttribute("list", list);
		
		return "/danggun/danggunMain";
	}

	@RequestMapping(value = "/main", method = RequestMethod.POST)
	public @ResponseBody List<DanggunDTO> searchProduct(@RequestParam("searchInput") String searchInput,
			HttpSession session) {
		List<DanggunDTO> searchList = danggunService.searchProduct(searchInput);

		for (DanggunDTO danggun : searchList) {
			ProductImagesDTO searchImage = productImageService.selectAllImages(danggun.getDanggunNumber());
			danggun.setUrl(searchImage.getUrl());
		}
		return searchList;
	}

	@RequestMapping(value = "/insert", method = RequestMethod.GET)
	public String insertGet(HttpSession session, Model model) {
		if (session.getAttribute("userInfo") != null) {
			return "/danggun/danggunInsert";
		} else {
			model.addAttribute("message", "로그인이 필요한 페이지입니다.");
			return "login";
		}

	}

	@RequestMapping(value = "/insert", method = RequestMethod.POST)
	public @ResponseBody String insertPost(@RequestParam(value = "detailImagesLength", required=false) int detailImagesLength,@RequestPart(value="detailImages", required = false) MultipartFile[] detailImages, MultipartFile image,
			String clientId, String productName, int price, String detail) throws IllegalStateException, IOException {
		return danggunService.danggunInsert(detailImagesLength, detailImages, image, clientId, productName, price, detail)>0 ? "sucess" : "fail";
	}

//	상품 상세 목록 조회하기 
	@GetMapping(value = "/detail")
	public ModelAndView danggunDetail(@RequestParam("danggunNumber") int danggunNumber, HttpSession session) {
		ModelAndView mv = new ModelAndView("danggun/danggunDetail");
		
		DanggunDTO resultDanggun = danggunService.selectDanggun(((ClientsDTO)session.getAttribute("userInfo")).getClientId(), danggunNumber);
		System.out.println(resultDanggun.getWishListImg());
		mv.addObject("post",resultDanggun);

		return mv;
	}

	@RequestMapping("/wishLists")
	public @ResponseBody Map<String, Integer> danggunWishList(@RequestParam int danggunNumber, HttpSession session){
		System.out.println(danggunNumber);
		Map<String, Integer> result = danggunService.danggunWishList(((ClientsDTO)session.getAttribute("userInfo")).getClientId(), danggunNumber);
		System.out.println("result " + result);
		return result;
	}
	
	@PostMapping(value = "/update")
	public @ResponseBody boolean danggunUpdate(
			@RequestPart(value = "imageFiles", required = false) MultipartFile[] imageFiles,
			@RequestParam(value = "imageFilesNumber", required = false) int[] imageFilesNumber,
			@RequestParam(value = "oldImageURL", required = false) String[] oldImageURL,
			@RequestPart(value = "newDetailImages", required = false) MultipartFile[] newDetailImages,
			@RequestParam("danggunNumber") Integer danggunNumber, 
			@RequestParam("clientId") String clientId,
			@RequestParam("name") String productName, 
			@RequestParam("price") Integer price,
			@RequestParam("detail") String detail, 
			@RequestParam("tradeHistoryNumber") Integer tradeHistoryNumber,
			@RequestParam("imagesLength") int imagesLength,
			@RequestParam("newImagesLength") int newImagesLength,
			HttpSession session)
			throws IllegalStateException, IOException {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");

		return danggunService.updateDanggun(imageFiles, imageFilesNumber, oldImageURL, newDetailImages,
				userInfo.getClientId(), danggunNumber, clientId, productName, price, detail, tradeHistoryNumber, imagesLength, newImagesLength);
	}

	@RequestMapping(value = "/delete", method = RequestMethod.DELETE, produces = "text/plain;charset=utf-8")
	public @ResponseBody String danggunDelete(@RequestBody DanggunDTO danggun, HttpSession session) {
		ClientsDTO clientInfo = (ClientsDTO) session.getAttribute("userInfo");
		String clientId = clientInfo.getClientId();
		boolean result;
		if (clientId.equals(danggun.getClientId())) {
			result = danggunService.deleteDanggun(danggun);
		} else { // 다를 때
			result = false;
		}
		return (result == true) ? "삭제 성공" : "삭제 실패";
	}
	
	
	
	
	
	
	
}
