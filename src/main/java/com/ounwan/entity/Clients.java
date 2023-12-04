package com.ounwan.entity;

import java.sql.Date;

import lombok.Builder;
import lombok.Getter;
import lombok.ToString;

@Getter
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
	private int privacyTerms;
	private boolean emailCheck;
	private boolean activationCheck;
	private boolean qualifiedCheck;
	private String profileURL;
}
