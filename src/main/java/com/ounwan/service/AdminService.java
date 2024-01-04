package com.ounwan.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.ounwan.dto.AdminDTO;
import com.ounwan.entity.Admin;
import com.ounwan.repository.AdminDAO;

@Service
public class AdminService {

	@Autowired
	AdminDAO adminDAO;

	public AdminDTO checkAuthorization(AdminDTO adminDTO) {
		Admin admin = adminDAO.checkAuthorization(adminDTO.getAdminId());
		if (admin != null) {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if (encoder.matches(adminDTO.getPassword(), admin.getPassword())) {
				return changeDTO(admin);
			}
		}
		return null;
	}
	
	public Map<String, Object> getAdminTotal() {
		Map<String, Object> result = new HashMap<>();
		List<String> dates = new ArrayList<>();
		List<Integer> totalPrice = new ArrayList<>();
		List<Integer> communityAct = new ArrayList<>();
		List<String> categories = new ArrayList<>();
		List<Integer> totalPriceCategory = new ArrayList<>();
		List<Integer> totalDanggun = new ArrayList<>();
		List<Integer> communityCnt = new ArrayList<>();
		List<Integer> storeCnt = new ArrayList<>();
		
		for(Map<String, Object> row : adminDAO.getTotalPriceByDate()) {
			dates.add(0, "'" + row.get("DATE").toString() + "'");
			totalPrice.add(0, Integer.parseInt(String.valueOf(row.get("TOTAL_PRICE"))));
		}
		for(Map<String, Object> row : adminDAO.getCommunityAct()) {
			communityAct.add(0, Integer.parseInt(String.valueOf(row.get("CNT"))));
		}
		for(Map<String, Object> row : adminDAO.getTotalByCategory()) {
			categories.add(0, "'" + row.get("CATEGORY").toString() + "'");
			totalPriceCategory.add(0, Integer.parseInt(String.valueOf(row.get("TOTAL_PRICE"))));
		}
		for(Map<String, Object> row : adminDAO.getDanggunTotal()) {
			totalDanggun.add(0, Integer.parseInt(String.valueOf(row.get("CNT"))));
		}
		for(Map<String, Object> row : adminDAO.getReportTotal()) {
			communityCnt.add(0, Integer.parseInt(String.valueOf(row.get("COMMUNITY_CNT"))));
			storeCnt.add(0, Integer.parseInt(String.valueOf(row.get("STORE_CNT"))));
		}
		
		result.put("date", dates);
		result.put("totalPrice", totalPrice);
		result.put("communityAct", communityAct);
		result.put("categories", categories);
		result.put("totalPriceCategory", totalPriceCategory);
		result.put("totalDanggun", totalDanggun);
		result.put("communityCnt", communityCnt);
		result.put("storeCnt", storeCnt);
		
		return result;
	}	
	
	public AdminDTO changeDTO(Admin admin) {
		return AdminDTO.builder()
						.adminId(admin.getAdminId())
						.name(admin.getName())
						.password(admin.getPassword())
						.build();
	}
	
	public Admin changeEntity(AdminDTO adminDTO) {
		return Admin.builder()
					.adminId(adminDTO.getAdminId())
					.name(adminDTO.getName())
					.password(adminDTO.getPassword())
					.build();
	}
}
