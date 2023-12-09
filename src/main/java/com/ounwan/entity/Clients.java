package com.ounwan.entity;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
@Builder
@ToString

public class Clients {
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
	private Date withdrawaDate;

}
