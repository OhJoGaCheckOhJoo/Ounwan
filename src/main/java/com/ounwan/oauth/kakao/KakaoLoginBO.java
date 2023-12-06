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

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Component
public class KakaoLoginBO {
	private static String accessToken = "";
	private static String refreshToken = "";
	private static final String RESTAPI_KEY = "";

	public String getReturnAccessToken(String code) throws IOException {
		String reqURL = "https://kauth.kakao.com/oauth/token";
		URL url = new URL(reqURL);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		// 1. HttpURLConnection 설정 값 셋팅
		conn.setRequestMethod("POST");
		conn.setDoOutput(true);

		// 2. buffer 스트림 객체 값 셋팅 후 요청
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		StringBuilder sb = new StringBuilder();
		sb.append("grant_type=authorization_code")
		        .append("&client_id=") // 앱 KEY VALUE
				.append(RESTAPI_KEY)
				.append("&redirect_uri=http://localhost:9090/myapp/oauth/kakao") // 앱 CALLBACK 경로
				.append("&code=" + code)
		        .append("scope=name,birhday,birthyear,phone_number");
		
		bw.write(sb.toString());
		bw.flush();

		// RETURN 값 result 변수에 저장
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
		String line = "";
		String result = "";

		while ((line = br.readLine()) != null) {
			result += line;
		}

		JsonElement element = (JsonElement) JsonParser.parseString(result);

		accessToken = element.getAsJsonObject().get("access_token").getAsString();
		refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

		br.close();
		bw.close();

		return accessToken;
	}

	public Map<String, Object> getUserInfo(String accessToken) throws IOException {
		String reqURL = "https://kauth.kakao.com/v2/user/me";
		Map<String, Object> resultMap = new HashMap<>();

		URL url = new URL(reqURL);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		conn.setRequestMethod("GET");
		conn.setRequestProperty("Authorization", "Bearer " + accessToken);

		int responseCode = conn.getResponseCode();

		// RETURN 값 result 변수에 저장
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
		String birthday = account.getAsJsonObject().get("birthyear").getAsString() + "-"
				+ account.getAsJsonObject().get("birthday").getAsString();

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
