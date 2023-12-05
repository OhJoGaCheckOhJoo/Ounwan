package com.ounwan.dto;

import java.sql.Date;

import org.springframework.stereotype.Component;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.ToString;

@Getter
@Builder
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ClientsDTO {
	private String clientId;
	private String name;
	private String password;
	private String email;
	private Date birthday;
	private String phone;
	private String address;
	private String addressDetail;
	private String zipCode;
	private Integer privacyTerms;
	private Boolean emailCheck;
	private Boolean activationCheck;
	private Boolean qualifiedCheck;
	private String profileURL;
	private String emailAuth;
	private String socialType;
	private String socialId;
}
