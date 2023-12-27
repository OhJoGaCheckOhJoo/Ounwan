package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.FAQDTO;
import com.ounwan.entity.FAQ;
import com.ounwan.repository.FAQDAO;

@Service
public class FAQService {
	
	@Autowired
	FAQDAO faqDAO;
	
	final static String[] CATEGORY = {"배송", "중고", "커뮤니티"};
	
	public int countFAQList(int category) {
		int numOfFaq = faqDAO.countFAQList(category);
		return numOfFaq / 10 + (numOfFaq % 10 > 0 ? 1 : 0);
	}
	
	public List<FAQDTO> getFAQList(int category, int offset) {
		Map<String, Object> data = new HashMap<>();
		List<FAQDTO> result = new ArrayList<>();
		data.put("category", category);
		data.put("offset", offset);
		for(FAQ faq : faqDAO.getFAQList(data)) {
			result.add(changeFaqEntity(faq));
		}
		return result;
	}
	
	public FAQDTO changeFaqEntity(FAQ faq) {
		return FAQDTO.builder()
				.faqNumber(faq.getFaqNumber())
				.question(faq.getQuestion())
				.answer(faq.getAnswer())
				.category(CATEGORY[faq.getCategory() - 1])
				.build();
	}
}
