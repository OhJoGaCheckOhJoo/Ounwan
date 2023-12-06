package com.ounwan.oauth.kakao;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.sql.Date;
import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoLoginBO {
	private static String accessToken = "";
	private static String refreshToken = "";
	private static final String RESTAPI_KEY = "adbcbb3bee3e8e19d5bca1d40c3e3dc7";

	public String getURL() {
		StringBuffer bf = new StringBuffer();
		bf.append("https://kauth.kakao.com/oauth/authorize?client_id=")
        .append(RESTAPI_KEY)
        .append("&redirect_uri=http://localhost:9090/myapp/oauth/kakao")
        .append("&response_type=code");	
		
		return bf.toString();
	}
	
	public String getReturnAccessToken(String code) throws IOException {
		System.out.println("HEREREERERERERERERERERE");
		String reqURL = "https://kauth.kakao.com/oauth/token";
		URL url = new URL(reqURL);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setDoOutput(true);

		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		StringBuilder sb = new StringBuilder();
		sb.append("grant_type=authorization_code")
			.append("&client_id=")
			.append(RESTAPI_KEY)
			.append("&redirect_uri=http://localhost:9090/myapp/oauth/kakao")
			.append("&code=" + code)
			.append("scope=name,birthday,birthyear,phone_number");
		bw.write(sb.toString());
		bw.flush();

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String line = "";
		String result = "";

		while ((line = br.readLine()) != null) {
			result += line;
		}
		System.out.println("bufferedReader: " + result);
		JsonElement element = (JsonElement) JsonParser.parseString(result);
		System.out.println("element : " + element);
		accessToken = element.getAsJsonObject().get("access_token").getAsString();
		refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

		br.close();
		bw.close();

		return accessToken;
	}
	
	public Map<String, Object> getUserInfo(String accessToken) throws IOException{
		String reqURL = "https://kauth.kakao.com/v2/user/me";
		Map<String, Object> resultMap = new HashMap<>();
		
		URL url = new URL(reqURL);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		conn.setRequestMethod("GET");
		
		conn.setRequestProperty("Authorization", "Bearer " + accessToken);
		
		int responseCode = conn.getResponseCode();
		System.out.println("responseCode: " + responseCode);		

		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String line = "";
		String result = "";

		while ((line = br.readLine()) != null) {
			result += line;
		}
		
		JsonElement element = (JsonElement) JsonParser.parseString(result);
		
		JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();
		JsonObject account = element.getAsJsonObject().get("kakao_account").getAsJsonObject();		
		String token = properties.getAsJsonObject().get("id").getAsString();
		
		String profileURL = account.getAsJsonObject().get("profile_image").getAsString(); 
		String email = account.getAsJsonObject().get("account_email").getAsString();
		String name = account.getAsJsonObject().get("name").getAsString();
		String birthday = account.getAsJsonObject().get("birthyear").getAsString() 
				+ "-" + account.getAsJsonObject().get("birthday").getAsString();
		String phone = account.getAsJsonObject().get("phone_number").getAsString();				
		
		resultMap.put("token", token);
		resultMap.put("profileURL", profileURL);
		resultMap.put("email", email);
		resultMap.put("name", name);
		resultMap.put("birthday", Date.valueOf(birthday));
		resultMap.put("phone", phone);
		
		return resultMap;
	}

}
