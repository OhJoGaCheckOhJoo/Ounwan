package com.ounwan.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.entity.Clients;
import com.ounwan.repository.ClientsDAO;

@Service
public class ClientsService {
	@Autowired
	ClientsDAO clientsDAO;

	public boolean checkLogin(String id, String password) {  
		String dbpassword = clientsDAO.checkLogin(id);
		if (dbpassword == null) {
			return false;
		} else {
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if(encoder.matches(password,dbpassword)) {
				return true;
			}else {
				return false;
			}
			 
		}
	}
	
	public ClientsDTO checkNaverToken(String token) {
		Clients client = clientsDAO.checkNaverToken(token);
		return (client != null) ? changeDTO(client) : null;
	}
	
	public Clients changeEntity(ClientsDTO client) {
        return Clients.builder()
                .clientId(client.getClientId())
                .name(client.getName())
                .password(client.getPassword())
                .email(client.getEmail())
                .birthday(client.getBirthday())
                .phone(client.getPhone())
                .address(client.getAddress())
                .addressDetail(client.getAddressDetail())
                .zipCode(client.getZipCode())
                .privacyTerms(client.getPrivacyTerms())
                .emailCheck(client.getEmailCheck())
                .activationCheck(client.getActivationCheck())
                .qualifiedCheck(client.getQualifiedCheck())
                .profileURL(client.getProfileURL())
                .emailAuth(client.getEmailAuth())
                .socialType(client.getSocialType())
                .socialId(client.getSocialId())
                .build();
    }
    
    public ClientsDTO changeDTO(Clients client) {
        return ClientsDTO.builder()
                .clientId(client.getClientId())
                .name(client.getName())
                .password(client.getPassword())
                .email(client.getEmail())
                .birthday(client.getBirthday())
                .phone(client.getPhone())
                .address(client.getAddress())
                .addressDetail(client.getAddressDetail())
                .zipCode(client.getZipCode())
                .privacyTerms(client.getPrivacyTerms())
                .emailCheck(client.isEmailCheck())
                .activationCheck(client.isActivationCheck())
                .qualifiedCheck(client.isQualifiedCheck())
                .profileURL(client.getProfileURL())
                .emailAuth(client.getEmailAuth())
                .socialType(client.getSocialType())
                .socialId(client.getSocialId())
                .build();
    }

	public ClientsDTO checkKakaoToken(String token) {
		// System.out.println("here!!!!");
		Clients client = clientsDAO.checkKakaoToken(token);
		return (client != null) ? changeDTO(client) : null;
	}

}
