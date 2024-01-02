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
	
	public Map<String, Object> getTotalPriceByDate() {
		Map<String, Object> result = new HashMap<>();
		List<String> dates = new ArrayList<>();
		List<Integer> totalPrice = new ArrayList<>();
		for(Map<String, Object> row : adminDAO.getTotalPriceByDate()) {
			dates.add("'" + row.get("DATE").toString() + "'");
			totalPrice.add(Integer.parseInt(String.valueOf(row.get("TOTAL_PRICE"))));
		}
		result.put("date", dates);
		result.put("totalPrice", totalPrice);
		return result;
	}
	
	public List<Integer> getCommunityAct() {
		List<Integer> communityAct = new ArrayList<>();
		for(Map<String, Object> row : adminDAO.getCommunityAct()) {
			communityAct.add(Integer.parseInt(String.valueOf(row.get("CNT"))));
		}
		return communityAct;
	}
	
	public Map<String, Object> getTotalByCategory() {
		Map<String, Object> result = new HashMap<>();
		List<String> categories = new ArrayList<>();
		List<Integer> totalPrice = new ArrayList<>();
		for(Map<String, Object> row : adminDAO.getTotalByCategory()) {
			categories.add("'" + row.get("CATEGORY").toString() + "'");
			totalPrice.add(Integer.parseInt(String.valueOf(row.get("TOTAL_PRICE"))));
		}
		result.put("categories", categories);
		result.put("totalPriceCategory", totalPrice);
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
