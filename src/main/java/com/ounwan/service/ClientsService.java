package com.ounwan.service;

import java.util.UUID;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.stereotype.Service;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.entity.Clients;
import com.ounwan.repository.ClientsDAO;

@Service
public class ClientsService {

	@Autowired
	ClientsDAO clientsDAO;

	@Autowired
	MailSender sender;

	public int createAccount(ClientsDTO client) {
		String password = hashPassword(client.getPassword());
		client.setPassword(password);
		client.setEmailAuth(UUID.randomUUID().toString());
		client.setEmailCheck(false);
		client.setQualifiedCheck(false);
		client.setActivationCheck(false);
		int result = clientsDAO.createAccount(changeEntity(client));
		if (result > 0) {
			sendEmailAuths(client.getEmail(), client.getEmailAuth());
			return 1;
		}
		return 0;
	}

	public boolean checkId(String clientId) {
		int result = clientsDAO.checkId(clientId);
		return (result > 0) ? true : false;
	}

	public boolean checkEmail(String email) {
		int result = clientsDAO.checkEmail(email);
		return (result > 0) ? true : false;
	}
	
	public ClientsDTO checkNaverToken(String token) {
		Clients client = clientsDAO.checkNaverToken(token);
		return (client != null) ? changeDTO(client) : null;
	}
	
	public ClientsDTO checkKakaoToken(String token) {
		Clients client = clientsDAO.checkKakaoToken(token);
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

	public String hashPassword(String plainTextPassword) {
		// 문자열 암호화해서 변환
		return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
	}

	public String sendEmailAuths(String email, String emailAuth) {

		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email); // 수신자
		message.setSubject("오운완 테스트");
		message.setText("인증번호 발송했습니다. " + emailAuth);
		message.setFrom("ounwan50@gmail.com");

		sender.send(message);

		return "aa";
	}
}
