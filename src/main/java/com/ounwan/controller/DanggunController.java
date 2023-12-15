package com.ounwan.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
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
	ProductImagesService productImagesService;

	@Autowired
	TradeHistoryService tradeHistoryService;

	@Autowired
	WishListsService wishListsService;

	@GetMapping("/main")
	public String danggunMain() {
		return "/danggun/danggunMain";
	}

//	상품 상세 목록 조회하기 
	@GetMapping(value = "/detail")
	public ModelAndView danggunDetail(@RequestParam("danggunNumber") int danggunNumber) {
		ModelAndView mv = new ModelAndView("danggun/danggunDetail");

		DanggunDTO resultDanggun = danggunService.selectDanggun(danggunNumber);
		if (resultDanggun != null) {
			mv.addObject("post", resultDanggun);
			int tradeHistoryNumber = resultDanggun.getTradeHistoryNumber();
			String step = tradeHistoryService.selectTradeStep(tradeHistoryNumber);
			mv.addObject("tradeStep", step);
		}

		List<ProductImagesDTO> resultImages = productImagesService.selectImages(danggunNumber);
		System.out.println(resultImages);
		if (resultImages != null)
			mv.addObject("danggunImage", resultImages);

		mv.addObject("zzimCount", wishListsService.selectCountZzim(danggunNumber));

		return mv;
	}

	@PostMapping(value = "/update")
	public @ResponseBody boolean danggunUpdate(
			@RequestPart(value = "imageFiles", required = false) MultipartFile[] imageFiles,
			@RequestParam(value = "imageFilesNumber", required = false) int[] imageFilesNumber,
			@RequestParam(value = "oldImageURL", required = false) String[] oldImageURL,
			@RequestPart(value = "newDetailImages", required = false) MultipartFile[] newDetailImages,
			@RequestParam("danggunNumber") Integer danggunNumber, 
			@RequestParam("clientId") String clientId,
			@RequestParam("name") String name, 
			@RequestParam("price") Integer price,
			@RequestParam("detail") String detail, 
			@RequestParam("tradeHistoryNumber") Integer tradeHistoryNumber,
			@RequestParam("imagesLength") int imagesLength,
			@RequestParam("newImagesLength") int newImagesLength,
			HttpSession session)
			throws IllegalStateException, IOException {
		ClientsDTO userInfo = (ClientsDTO) session.getAttribute("userInfo");

		return danggunService.updateDanggun(imageFiles, imageFilesNumber, oldImageURL, newDetailImages,
				userInfo.getClientId(), danggunNumber, clientId, name, price, detail, tradeHistoryNumber, imagesLength, newImagesLength);
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
