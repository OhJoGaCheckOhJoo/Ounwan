package com.ounwan.service;

import java.io.IOException;
import java.util.Random;
import java.util.UUID;

import javax.mail.MessagingException;
import javax.mail.internet.MimeMessage;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.entity.Clients;
import com.ounwan.repository.ClientsDAO;

@Service
public class ClientsService {
	@Autowired
	ClientsDAO clientsDAO;
	
	@Autowired
	AmazonS3 amazonS3;

	@Autowired
	JavaMailSender sender;
	
	private static final String BUCKET = "ounwan";
 
	public boolean createAccount(ClientsDTO client) throws MessagingException {
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
		if(clientId.contains("admin")) return false;
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
	
	public String findPassword(String id, String email) throws MessagingException {
		Clients client = clientsDAO.findPassword(Clients.builder()
													.clientId(id)
													.email(email)
													.build());
		if(client != null) {
			String newPassword = resetPassword();
			sendTempPassword(client.getEmail(), newPassword);
			client.setPassword(hashPassword(newPassword));
			int result = clientsDAO.updateRandomPassword(client);
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
	

	public String setImage(MultipartFile multipartFile) throws IllegalStateException, IOException {
		String newFileName = System.currentTimeMillis() + "." + multipartFile.getContentType().split("/")[1];
		
        ObjectMetadata metadata = new ObjectMetadata();
        metadata.setContentLength(multipartFile.getSize());
        metadata.setContentType(multipartFile.getContentType());

        amazonS3.putObject(BUCKET, newFileName, multipartFile.getInputStream(), metadata);
		return amazonS3.getUrl(BUCKET, newFileName).toString();
	}

	
	public void sendTempPassword(String email, String newPassword) throws MessagingException{
		MimeMessage mimeMessage = sender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
		messageHelper.setFrom("ounwan50@gmail.com");
		messageHelper.setTo(email);
		messageHelper.setSubject("오운완 임시 비밀번호 발급입니다.");
		String msg = getTempPasswordHTML(newPassword);
		messageHelper.setText("text/html", msg);
		
		sender.send(mimeMessage);
	}
	
	public String sendEmailAuths(String email, String emailAuth) throws MessagingException {
		MimeMessage mimeMessage = sender.createMimeMessage();
		MimeMessageHelper messageHelper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
		
		messageHelper.setFrom("ounwan50@gmail.com");
		messageHelper.setTo(email);
		messageHelper.setSubject("오운완 이메일 인증입니다.");
		String msg = getEmailAuthHTML(emailAuth);
		messageHelper.setText("text/html", msg);

		sender.send(mimeMessage);

		return "success";
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
                .profileUrl(client.getProfileUrl())
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
                .profileUrl(client.getProfileUrl())
                .emailAuth(client.getEmailAuth())
                .socialType(client.getSocialType())
                .socialId(client.getSocialId())
                .build();
    }
    
    public String getEmailAuthHTML(String code) {
    	String result = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n"
    			+ "<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\n"
    			+ "    <head>\n"
    			+ "        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n"
    			+ "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
    			+ "        <meta name=\"x-apple-disable-message-reformatting\">\n"
    			+ "        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
    			+ "        <title></title>\n"
    			+ "        <style type=\"text/css\">\n"
    			+ "            @media only screen and (min-width: 620px) {\n"
    			+ "                .u-row {\n"
    			+ "                    width: 600px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-row .u-col {\n"
    			+ "                    vertical-align: top;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-row .u-col-100 {\n"
    			+ "                    width: 600px !important;\n"
    			+ "                }\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            @media (max-width: 620px) {\n"
    			+ "                .u-row-container {\n"
    			+ "                    max-width: 100% !important;\n"
    			+ "                    padding-left: 0px !important;\n"
    			+ "                    padding-right: 0px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-row .u-col {\n"
    			+ "                    min-width: 320px !important;\n"
    			+ "                    max-width: 100% !important;\n"
    			+ "                    display: block !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-row {\n"
    			+ "                    width: 100% !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-col {\n"
    			+ "                    width: 100% !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-col > div {\n"
    			+ "                    margin: 0 auto;\n"
    			+ "                }\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            body {\n"
    			+ "                margin: 0;\n"
    			+ "                padding: 0;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            table, tr, td {\n"
    			+ "                vertical-align: top;\n"
    			+ "                border-collapse: collapse;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            p {\n"
    			+ "                margin: 0;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            .ie-container table, .mso-container table {\n"
    			+ "                table-layout: fixed;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            * {\n"
    			+ "                line-height: inherit;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            a[x-apple-data-detectors='true'] {\n"
    			+ "                color: inherit !important;\n"
    			+ "                text-decoration: none !important;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            table, td {\n"
    			+ "                color: #000000;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            #u_body a {\n"
    			+ "                color: #0000ee;\n"
    			+ "                text-decoration: underline;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            @media (max-width: 480px) {\n"
    			+ "                #u_content_divider_1 .v-container-padding-padding {\n"
    			+ "                    padding: 15px 0px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                #u_content_text_2 .v-container-padding-padding {\n"
    			+ "                    padding: 10px 20px 30px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                #u_content_text_8 .v-container-padding-padding {\n"
    			+ "                    padding: 10px 20px 30px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                #u_content_button_2 .v-container-padding-padding {\n"
    			+ "                    padding: 10px 10px 50px !important;\n"
    			+ "                }\n"
    			+ "            }\n"
    			+ "        </style>\n"
    			+ "    </head>\n"
    			+ "    <body class=\"clean-body u_body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #e7e7e7;color: #000000\">\n"
    			+ "        <table id=\"u_body\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #e7e7e7;width:100%\" cellpadding=\"0\" cellspacing=\"0\">\n"
    			+ "            <tbody>\n"
    			+ "                <tr style=\"vertical-align: top\">\n"
    			+ "                    <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\n"
    			+ "                        <div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\n"
    			+ "                            <div class=\"u-row\" style=\"margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">\n"
    			+ "                                <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\n"
    			+ "                                    <div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\n"
    			+ "                                        <div style=\"background-color: #333333;height: 100%;width: 100% !important;\">\n"
    			+ "                                            <div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\">\n"
    			+ "                                                <table style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:60px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n"
    			+ "                                                                    <tr>\n"
    			+ "                                                                        <td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">\n"
    			+ "                                                                            <img align=\"center\" border=\"0\" src=\"https://ounwan.s3.ap-northeast-2.amazonaws.com/1703665002074.png\" alt=\"image\" title=\"image\" style=\"outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;clear: both;display: inline-block !important;border: none;height: auto;float: none;width: 100%;max-width: 480px;\" width=\"480\"/>\n"
    			+ "                                                                        </td>\n"
    			+ "                                                                    </tr>\n"
    			+ "                                                                </table>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 10px 15px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <h1 style=\"margin: 0px; color: #cbf83e; line-height: 100%; text-align: center; word-wrap: break-word; font-size: 40px; font-weight: 700;\">\n"
    			+ "                                                                    <span>\n"
    			+ "                                                                        <span>\n"
    			+ "                                                                            <span>회원 가입을 축하드립니다!</span>\n"
    			+ "                                                                        </span>\n"
    			+ "                                                                    </span>\n"
    			+ "                                                                </h1>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table id=\"u_content_divider_1\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:15px 10px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"15%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 6px solid #535353;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n"
    			+ "                                                                    <tbody>\n"
    			+ "                                                                        <tr style=\"vertical-align: top\">\n"
    			+ "                                                                            <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n"
    			+ "                                                                                <span>&#160;</span>\n"
    			+ "                                                                            </td>\n"
    			+ "                                                                        </tr>\n"
    			+ "                                                                    </tbody>\n"
    			+ "                                                                </table>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table id=\"u_content_text_2\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:30px 60px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <div style=\"font-size: 20px; color: #eee7d8; line-height: 140%; text-align: center; word-wrap: break-word;\">\n"
    			+ "                                                                    <p style=\"line-height: 140%;\">\n"
    			+ "                                                                        <span data-metadata=\"&lt;!--(figmeta)eyJmaWxlS2V5IjoiSEFUTG5wTFpKU2hzRjdvbzFuM2ZVZCIsInBhc3RlSUQiOjU0OTU5NTUxMiwiZGF0YVR5cGUiOiJzY2VuZSJ9Cg==(/figmeta)--&gt;\" style=\"line-height: 28px;\">🎉 </span>\n"
    			+ "                                                                        <span style=\"line-height: 28px;\">이메일 인증을 완료해 주세요 🎉</span>\n"
    			+ "                                                                    </p>\n"
    			+ "                                                                </div>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table id=\"u_content_text_8\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 60px 30px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <div style=\"font-size: 17px; color: #eee7d8; line-height: 140%; text-align: left; word-wrap: break-word;\">\n"
    			+ "                                                                    <p style=\"line-height: 140%;\">이메일 인증번호  : "
    			+ code
    			+ "</p>\n"
    			+ "                                                                </div>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table id=\"u_content_button_2\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 10px 60px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <div align=\"center\">\n"
    			+ "                                                                    <a href=\"http://localhost:9090/myapp/clients/emailAuth\" target=\"_blank\" class=\"v-button\" style=\"box-sizing: border-box;display: inline-block;text-decoration: none;-webkit-text-size-adjust: none;text-align: center;color: #333333; background-color: #cbf83e; border-radius: 14px;-webkit-border-radius: 14px; -moz-border-radius: 14px; width:auto; max-width:100%; overflow-wrap: break-word; word-break: break-word; word-wrap:break-word; mso-border-alt: none;font-size: 15px;\">\n"
    			+ "                                                                        <span style=\"display:block;padding:10px 20px;line-height:120%;\">\n"
    			+ "                                                                            <span data-metadata=\"&lt;!--(figmeta)eyJmaWxlS2V5IjoiSEFUTG5wTFpKU2hzRjdvbzFuM2ZVZCIsInBhc3RlSUQiOjE3OTY2NTMwMDUsImRhdGFUeXBlIjoic2NlbmUifQo=(/figmeta)--&gt;\" style=\"line-height: 18px;\"></span>\n"
    			+ "                                                                            <span data-buffer=\"&lt;!--(figma)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(/figma)--&gt;\" style=\"line-height: 18px;\"></span>\n"
    			+ "                                                                            <span style=\"line-height: 18px;\">이메일 인증하기</span>\n"
    			+ "                                                                        </span>\n"
    			+ "                                                                    </a>\n"
    			+ "                                                                </div>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                            </div>\n"
    			+ "                                        </div>\n"
    			+ "                                    </div>\n"
    			+ "                                </div>\n"
    			+ "                            </div>\n"
    			+ "                        </div>\n"
    			+ "                    </td>\n"
    			+ "                </tr>\n"
    			+ "            </tbody>\n"
    			+ "        </table>\n"
    			+ "    </body>\n"
    			+ "</html>\n";
    	return result;
    }
    
    public String getTempPasswordHTML (String tempPassword) {
    	String result = "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n"
    			+ "<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\n"
    			+ "    <head>\n"
    			+ "        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n"
    			+ "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
    			+ "        <meta name=\"x-apple-disable-message-reformatting\">\n"
    			+ "        <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\n"
    			+ "        <title></title>\n"
    			+ "        <style type=\"text/css\">\n"
    			+ "            @media only screen and (min-width: 620px) {\n"
    			+ "                .u-row {\n"
    			+ "                    width: 600px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-row .u-col {\n"
    			+ "                    vertical-align: top;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-row .u-col-100 {\n"
    			+ "                    width: 600px !important;\n"
    			+ "                }\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            @media (max-width: 620px) {\n"
    			+ "                .u-row-container {\n"
    			+ "                    max-width: 100% !important;\n"
    			+ "                    padding-left: 0px !important;\n"
    			+ "                    padding-right: 0px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-row .u-col {\n"
    			+ "                    min-width: 320px !important;\n"
    			+ "                    max-width: 100% !important;\n"
    			+ "                    display: block !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-row {\n"
    			+ "                    width: 100% !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-col {\n"
    			+ "                    width: 100% !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                .u-col > div {\n"
    			+ "                    margin: 0 auto;\n"
    			+ "                }\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            body {\n"
    			+ "                margin: 0;\n"
    			+ "                padding: 0;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            table, tr, td {\n"
    			+ "                vertical-align: top;\n"
    			+ "                border-collapse: collapse;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            p {\n"
    			+ "                margin: 0;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            .ie-container table, .mso-container table {\n"
    			+ "                table-layout: fixed;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            * {\n"
    			+ "                line-height: inherit;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            a[x-apple-data-detectors='true'] {\n"
    			+ "                color: inherit !important;\n"
    			+ "                text-decoration: none !important;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            table, td {\n"
    			+ "                color: #000000;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            #u_body a {\n"
    			+ "                color: #0000ee;\n"
    			+ "                text-decoration: underline;\n"
    			+ "            }\n"
    			+ "\n"
    			+ "            @media (max-width: 480px) {\n"
    			+ "                #u_content_divider_1 .v-container-padding-padding {\n"
    			+ "                    padding: 15px 0px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                #u_content_text_2 .v-container-padding-padding {\n"
    			+ "                    padding: 10px 20px 30px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                #u_content_text_8 .v-container-padding-padding {\n"
    			+ "                    padding: 10px 20px 30px !important;\n"
    			+ "                }\n"
    			+ "\n"
    			+ "                #u_content_button_2 .v-container-padding-padding {\n"
    			+ "                    padding: 10px 10px 50px !important;\n"
    			+ "                }\n"
    			+ "            }\n"
    			+ "        </style>\n"
    			+ "    </head>\n"
    			+ "    <body class=\"clean-body u_body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #e7e7e7;color: #000000\">\n"
    			+ "        <table id=\"u_body\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #e7e7e7;width:100%\" cellpadding=\"0\" cellspacing=\"0\">\n"
    			+ "            <tbody>\n"
    			+ "                <tr style=\"vertical-align: top\">\n"
    			+ "                    <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\n"
    			+ "                        <div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\n"
    			+ "                            <div class=\"u-row\" style=\"margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">\n"
    			+ "                                <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\n"
    			+ "                                    <div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\n"
    			+ "                                        <div style=\"background-color: #333333;height: 100%;width: 100% !important;\">\n"
    			+ "                                            <div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\">\n"
    			+ "                                                <table style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:60px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\n"
    			+ "                                                                    <tr>\n"
    			+ "                                                                        <td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">\n"
    			+ "                                                                            <img align=\"center\" border=\"0\" src=\"https://ounwan.s3.ap-northeast-2.amazonaws.com/1703665002074.png\" alt=\"image\" title=\"image\" style=\"outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;clear: both;display: inline-block !important;border: none;height: auto;float: none;width: 100%;max-width: 480px;\" width=\"480\"/>\n"
    			+ "                                                                        </td>\n"
    			+ "                                                                    </tr>\n"
    			+ "                                                                </table>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 10px 15px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <h1 style=\"margin: 0px; color: #cbf83e; line-height: 100%; text-align: center; word-wrap: break-word; font-size: 40px; font-weight: 700;\">\n"
    			+ "                                                                    <span>\n"
    			+ "                                                                        <span>\n"
    			+ "                                                                            <span>임시 비밀번호가 발급되었습니다</span>\n"
    			+ "                                                                        </span>\n"
    			+ "                                                                    </span>\n"
    			+ "                                                                </h1>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table id=\"u_content_divider_1\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:15px 10px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"15%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 6px solid #535353;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n"
    			+ "                                                                    <tbody>\n"
    			+ "                                                                        <tr style=\"vertical-align: top\">\n"
    			+ "                                                                            <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\n"
    			+ "                                                                                <span>&#160;</span>\n"
    			+ "                                                                            </td>\n"
    			+ "                                                                        </tr>\n"
    			+ "                                                                    </tbody>\n"
    			+ "                                                                </table>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table id=\"u_content_text_2\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:30px 60px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <div style=\"font-size: 20px; color: #eee7d8; line-height: 140%; text-align: center; word-wrap: break-word;\">\n"
    			+ "                                                                    <p style=\"line-height: 140%;\">\n"
    			+ "                                                                        <span data-metadata=\"&lt;!--(figmeta)eyJmaWxlS2V5IjoiSEFUTG5wTFpKU2hzRjdvbzFuM2ZVZCIsInBhc3RlSUQiOjU0OTU5NTUxMiwiZGF0YVR5cGUiOiJzY2VuZSJ9Cg==(/figmeta)--&gt;\" style=\"line-height: 28px;\">❗ </span>\n"
    			+ "                                                                        <span style=\"line-height: 28px;\">로그인 이후 비밀번호를 꼭 변경해 주세요❗</span>\n"
    			+ "                                                                    </p>\n"
    			+ "                                                                </div>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table id=\"u_content_text_8\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 60px 30px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <div style=\"font-size: 17px; color: #eee7d8; line-height: 140%; text-align: left; word-wrap: break-word;\">\n"
    			+ "                                                                    <p style=\"line-height: 140%;\">임시 비밀번호  :"
    			+ tempPassword
    			+ "</p>\n"
    			+ "                                                                </div>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                                <table id=\"u_content_button_2\" style=\"font-family:arial,helvetica,sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\n"
    			+ "                                                    <tbody>\n"
    			+ "                                                        <tr>\n"
    			+ "                                                            <td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 10px 60px;font-family:arial,helvetica,sans-serif;\" align=\"left\">\n"
    			+ "                                                                <div align=\"center\">\n"
    			+ "                                                                    <a href=\"http://localhost:9090/myapp/clients/login\" target=\"_blank\" class=\"v-button\" style=\"box-sizing: border-box;display: inline-block;text-decoration: none;-webkit-text-size-adjust: none;text-align: center;color: #333333; background-color: #cbf83e; border-radius: 14px;-webkit-border-radius: 14px; -moz-border-radius: 14px; width:auto; max-width:100%; overflow-wrap: break-word; word-break: break-word; word-wrap:break-word; mso-border-alt: none;font-size: 15px;\">\n"
    			+ "                                                                        <span style=\"display:block;padding:10px 20px;line-height:120%;\">\n"
    			+ "                                                                            <span data-metadata=\"&lt;!--(figmeta)eyJmaWxlS2V5IjoiSEFUTG5wTFpKU2hzRjdvbzFuM2ZVZCIsInBhc3RlSUQiOjE3OTY2NTMwMDUsImRhdGFUeXBlIjoic2NlbmUifQo=(/figmeta)--&gt;\" style=\"line-height: 18px;\"></span>\n"
    			+ "                                                                            <span data-buffer=\"&lt;!--(figma)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(/figma)--&gt;\" style=\"line-height: 18px;\"></span>\n"
    			+ "                                                                            <span style=\"line-height: 18px;\">이메일 인증하기</span>\n"
    			+ "                                                                        </span>\n"
    			+ "                                                                    </a>\n"
    			+ "                                                                </div>\n"
    			+ "                                                            </td>\n"
    			+ "                                                        </tr>\n"
    			+ "                                                    </tbody>\n"
    			+ "                                                </table>\n"
    			+ "                                            </div>\n"
    			+ "                                        </div>\n"
    			+ "                                    </div>\n"
    			+ "                                </div>\n"
    			+ "                            </div>\n"
    			+ "                        </div>\n"
    			+ "                    </td>\n"
    			+ "                </tr>\n"
    			+ "            </tbody>\n"
    			+ "        </table>\n"
    			+ "    </body>\n"
    			+ "</html>\n";
    	return result;
    }
}
