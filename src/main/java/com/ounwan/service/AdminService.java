package com.ounwan.service;

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
			System.out.println("notnulllll");
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if (encoder.matches(adminDTO.getPassword(), admin.getPassword())) {
				return changeDTO(admin);
			}
		}
		return null;
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
