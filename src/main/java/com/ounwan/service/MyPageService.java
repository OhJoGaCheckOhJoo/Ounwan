package com.ounwan.service;



import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.entity.Clients;
import com.ounwan.repository.ClientsDAO;
import com.ounwan.repository.MyPageDAO;

@Service
public class MyPageService {

	@Autowired
	MyPageDAO myPageDAO;

	@Autowired
	ClientsDAO clientsDAO;
	


	public String getPwdById(String clientId) {
	    String encryptedPassword = myPageDAO.getPwdById(clientId); // 암호화된 비밀번호를 가져옵니다.
	    System.out.println("!!!encryptedPassword : "+ encryptedPassword);

	    if (encryptedPassword != null) {
	        return encryptedPassword; // 암호화된 비밀번호 반환
	    }
	    return null;
	}

	public ClientsDTO getUserInfo(String clientId) {
		return changeDTO(myPageDAO.getUserInfo(clientId));
	}

	
	public int modifyPwd(ClientsDTO client) {
		String newPassword = hashPassword(client.getPassword());
		client.setPassword(newPassword);
		int result = myPageDAO.modifyPwd(changeEntity(client));
		if (result > 0) {
			return 1;
		}
		return 0;
	}

	public int modifyUserInfo(ClientsDTO client) {
		client.setPhone(client.getPhone());
		client.setAddress(client.getAddress());
		client.setAddressDetail(client.getAddressDetail());
		client.setZipCode(client.getZipCode());

		int result = myPageDAO.modifyUserInfo(changeEntity(client));
		if (result > 0) {
			return 1;
		}
		return 0;
	}
	
	
	
	
	
	private static String hashPassword(String plainTextPassword) {
		// bcrypt 암호화
		return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
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
	                .emailCheck(client.getEmailCheck())
	                .activationCheck(client.getActivationCheck())
	                .qualifiedCheck(client.getQualifiedCheck())
	                .profileURL(client.getProfileURL())
	                .emailAuth(client.getEmailAuth())
	                .socialType(client.getSocialType())
	                .socialId(client.getSocialId())
	                .build();
	    }

}
