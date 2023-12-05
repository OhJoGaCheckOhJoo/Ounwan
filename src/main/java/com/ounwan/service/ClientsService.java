package com.ounwan.service;

import java.util.Random;

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
	ClientsDAO dao;
	
	@Autowired
	MailSender sender;
	
	public String findClientId(ClientsDTO clientDTO) {
		Clients client = change(clientDTO);
		Clients findClient = dao.findClientId(client);
		if(findClient == null) {
			return null;
		} else {
			return findClient.getClientId();
		}
	}
	
	public String findPassword(ClientsDTO clientsDTO) {
		Clients client = change(clientsDTO);
		int result = dao.findPassword(client);
		if(result > 0) {
			String newPassword = resetPassword();
			sendMail(client.getEmail(), newPassword);
			client.setPassword(hashPassword(newPassword));
			result = dao.updateRandomPassword(client);
			if(result > 0) {
				return "새 비밀번호 생성 성공";
			} else {
				return "새 비밀번호 생성 실패";
			}
		} else {
			return "회원정보 불일치";
		}
	}
	
	public Clients change(ClientsDTO client) {
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
				.emailCheck(false)
				.activationCheck(true)
				.qualifiedCheck(false)
				.profileURL(client.getProfileURL())
				.emailAuth(client.getEmailAuth())
				.socialType(client.getSocialType())
				.socialId(client.getSocialId())
				.build();
	}
	
	public void sendMail(String email, String newPassword) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email); // 수신자
		message.setSubject("오운완 테스트"); // 제목
		message.setText("새 비밀번호 : "+ newPassword); // 내용
		message.setFrom("ounwan50@gmail.com"); //발신자
		
		sender.send(message);
	}
	
	private static String hashPassword(String plainTextPassword) {
		// 문자열 암호화해서 반환
		return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt());
	}
	
	private String resetPassword() {
		int pwLength = 9;
		StringBuilder newPw = new StringBuilder();
		Random random = new Random();
		char[] symbol = {'?', '@', '!', '#', '$', '%', '&'};

		for (int i = 0; i < pwLength; i++) {
			int idx = random.nextInt(5);
			switch (idx) {
			// 대문자
			case 0:
				newPw.append((char) ((int) random.nextInt(26) + 65));
				break;
			// 소문자
			case 1:
				newPw.append((char) ((int) random.nextInt(26) + 97));
				break;
			// 특수문자
			case 2:
				newPw.append(symbol[(int) random.nextInt(7)]);
				break;
			// 숫자
			default:
				newPw.append(random.nextInt(10));
				break;
			}
		}
		// System.out.println(newPw);
		return newPw.toString();
	}

}
