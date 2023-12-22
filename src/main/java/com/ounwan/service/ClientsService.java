package com.ounwan.service;

import java.io.File;
import java.util.UUID;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;
import java.util.UUID;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.entity.Clients;
import com.ounwan.repository.ClientsDAO;

@Service
public class ClientsService {
	@Autowired
	ClientsDAO clientsDAO;

	@Autowired
	MailSender sender;
	
	private final static String UPLOADPATH = "/Users/karenyoon/Documents/GitHub/Back-end/src/main/webapp/resources";
	private final static String IMAGEPATH = "/images/uploads/";
 
	public boolean createAccount(ClientsDTO client) {
		String password = hashPassword(client.getPassword());
		client.setPassword(password);
		client.setQualifiedCheck(false);
		client.setActivationCheck(true);
		if (client.getSocialId() != null) {
			client.setEmailAuth(" ");
			client.setEmailCheck(true);
			int result = clientsDAO.createAccount(changeEntity(client));
			return (result > 0) ? true : false;
		} else {
			client.setEmailAuth(UUID.randomUUID().toString());
			client.setEmailCheck(false);
			int result = clientsDAO.createAccount(changeEntity(client));
			if (result > 0) {
				sendEmailAuths(client.getEmail(), client.getEmailAuth());
				return true;
			} 
			return false;
		}
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

	public ClientsDTO checkGoogleToken(String token) {
		Clients client = clientsDAO.checkGoogleToken(token);
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
	
	public boolean checkEmailAuth(ClientsDTO client) {
		String auth = clientsDAO.getEmailAuth(client.getClientId());
		if(auth == null) return false;
		int result = 0;
		if (auth.equals(client.getEmailAuth())) {
			result = clientsDAO.updateActivation(client.getClientId());
		}
		return (result > 0) ? true : false;
	}
	

	public String setImage(MultipartFile multipartFile) {
		String newFileName = System.currentTimeMillis() + "." + multipartFile.getContentType().split("/")[1]; // image/jpg
		File file = new File(UPLOADPATH + IMAGEPATH + newFileName);
		
		return "." + IMAGEPATH + newFileName;
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
		String msg = "<!DOCTYPE html>\n"
				+ "<html lang=\"en\">\n"
				+ "<head>\n"
				+ "    <meta charset=\"UTF-8\">\n"
				+ "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
				+ "    <title>Document</title>\n"
				+ "</head>\n"
				+ "<body>\n"
				+ "    <h2>이매일 인증 코드 입니다</h2>\n"
				+ "    <br>\n"
				+ "    <h3>인증번호 입니다: </h3> <h2>"
				+ emailAuth
				+ "</h2>\n"
				+ "    <br>\n"
				+ "    <h4>아래 링크로 이동해서 인증을 완료해 주세요~</h4>\n"
				+ "    <br>\n"
				+ "   <h3><a href=\"http://localhost:9090/myapp/clients/emailAuth\">이메일 인증하기</a></h3>\n"
				+ "</body>\n"
				+ "</html>";
		message.setTo(email); // 수신자
		message.setSubject("오운완 테스트");
		message.setText(msg);
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
