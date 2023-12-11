package com.ounwan.service;

import java.util.UUID;

import java.util.Random;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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

	public ClientsDTO checkLogin(String id, String password) {  
		System.out.println("id : " + id);
		System.out.println("password : " + password);
		Clients dbInfo = clientsDAO.checkLogin(id);
		
		System.out.println("dbInfo : " + dbInfo);
		if (dbInfo != null) {
			String dbpassword = dbInfo.getPassword();
			BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
			if(encoder.matches(password,dbpassword)) {
				System.out.println("왔나");
				return changeDTO(dbInfo);
			}else {
				return null;
			}
		} else {
			return null;
		}
	}
	
	public ClientsDTO checkNaverToken(String token) {
		Clients client = clientsDAO.checkNaverToken(token);
		return (client != null) ? changeDTO(client) : null;
	}

	public ClientsDTO checkKakaoToken(String token) {
		Clients client = clientsDAO.checkKakaoToken(token);
		return (client != null) ? changeDTO(client) : null;
	}
	
	public String findClientId(ClientsDTO clientDTO) {
		Clients client = clientsDAO.findClientId(changeEntity(clientDTO));
		if(client == null) {
			return null;
		} else {
			return client.getClientId();
		}
	}
	
	public String findPassword(ClientsDTO clientsDTO) {
		int result = clientsDAO.findPassword(changeEntity(clientsDTO));
		if(result > 0) {
			String newPassword = resetPassword();
			sendTempPassword(clientsDTO.getEmail(), newPassword);
			clientsDTO.setPassword(hashPassword(newPassword));
			result = clientsDAO.updateRandomPassword(changeEntity(clientsDTO));
			if(result > 0) {
				return "변경성공";
			} else {
				return "변경실패";
			}
		} else {
			return "회원조회실패";
		}
	}
	
	public String withdrawalClient(ClientsDTO clientsDTO) {
		int result = clientsDAO.withdrawalClient(changeEntity(clientsDTO));
		if(result > 0) {
			return "탈퇴 성공";
		} else {
			return "탈퇴 실패";
		}
	}
	
	public void sendTempPassword(String email, String newPassword) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(email); // 수신자
		message.setSubject("[오운완] 테스트"); // 제목
		message.setText("임시 비밀번호 : "+ newPassword); // 내용
		message.setFrom("ounwan50@gmail.com"); // 발신자
		
		sender.send(message);
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
	
	private static String hashPassword(String plainTextPassword) {
		// bcrypt 암호화
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
		return newPw.toString();
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
