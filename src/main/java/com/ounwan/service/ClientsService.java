package com.ounwan.service;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.entity.Clients;
import com.ounwan.repository.ClientsDAO;

@Service
public class ClientsService {

	@Autowired
	ClientsDAO clientsDAO;
	
	public int createAccount(ClientsDTO client) {
		return clientsDAO.createAccount(change(client));
	}
	
	public boolean checkId(String clientId) {
		int result = clientsDAO.checkId(clientId);
		return (result > 0) ? true : false;
	}
	
	public boolean checkEmail(String email) {
		int result = clientsDAO.checkEmail(email);
		return (result > 0) ? true : false;
	}
	
	public Clients change(ClientsDTO client) {
		return Clients.builder()
				.clientId(client.getClientId())
				.name(client.getName())
				.password(hashPassword(client.getPassword()))
				.email(client.getEmail())
				.birthday(client.getBirthday())
				.phone(client.getPhone())
				.address(client.getAddress())
				.addressDetail(client.getAddressDetail())
				.zipCode(client.getZipCode())
				.privacyTerms(client.getPrivacyTerms())
				.emailCheck(false)
				.activationCheck(true)
				.qualifiedCheck(false)
				.profileURL(client.getProfileURL())
				.emailAuth(client.getEmailAuth())
				.socialType(client.getSocialType())
				.socialId(client.getSocialId())
				.build();
	}

	
	public String hashPassword(String plainTextPassword) {
        // 문자열 암호화해서 반환
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
    }

	

	

}
