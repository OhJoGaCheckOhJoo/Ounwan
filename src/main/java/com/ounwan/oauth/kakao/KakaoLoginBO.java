package com.ounwan.oauth.kakao;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Service;

import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import com.google.gson.JsonParser;

@Service
public class KakaoLoginBO {
	private String accessToken = "";
	private String refreshToken = "";
	private String RESTAPI_KEY = "ss";
	private String redirectURI = "http://localhost:9090/myapp/oauth/kakao";

	public String getURL() {
		StringBuffer bf = new StringBuffer();
		bf.append("https://kauth.kakao.com/oauth/authorize?client_id=").append(RESTAPI_KEY)
				.append("&redirect_uri=http://localhost:9090/myapp/oauth/kakao").append("&response_type=code");

		return bf.toString();
	}

	public String getReturnAccessToken(String code) throws IOException {

		String reqURL = "https://kauth.kakao.com/oauth/token";

		URL url = new URL(reqURL);
		HttpURLConnection conn = (HttpURLConnection) url.openConnection();

		conn.setRequestMethod("POST");
		conn.setDoOutput(true);
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
		StringBuilder sb = new StringBuilder();

		sb.append("grant_type=authorization_code").append("&client_id=").append(RESTAPI_KEY).append("&redirect_uri=")
				.append(redirectURI).append("&code=" + code);

		bw.write(sb.toString());
		bw.flush();
		BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

		String line = "";
		String result = "";

		while ((line = br.readLine()) != null) {
			result += line;
		}
		System.out.println("bufferedReader: " + result);
		JsonParser parser = new JsonParser();
		
		JsonElement element = parser.parse(result);
		System.out.println("element : " + element);
		accessToken = element.getAsJsonObject().get("access_token").getAsString();
		refreshToken = element.getAsJsonObject().get("refresh_token").getAsString();

		br.close();
		bw.close();
		System.out.println("getaccesstoken");
		return accessToken;
	}

	public Map<String, Object> getUserInfo(String accessToken) throws IOException {
		String reqURL = "https://kapi.kakao.com/v2/user/me";
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
		System.out.println("전 = " + result);
		JsonParser parser = new JsonParser();
		JsonElement element = parser.parse(result);		

		JsonObject properties = element.getAsJsonObject().get("properties").getAsJsonObject();

		String token = element.getAsJsonObject().get("id").getAsString();

		String profileURL = properties.getAsJsonObject().get("profile_image").getAsString();
		String clientId = properties.getAsJsonObject().get("nickname").getAsString();


		resultMap.put("token", token);
		resultMap.put("profileURL", profileURL);
		resultMap.put("clientId", clientId);


		return resultMap;
	}

	public void logout(HttpSession session) {
		String reqURL = "https://kapi.kakao.com/v1/user/logout";
		String token = (String) session.getAttribute("accessToken");
        try {
            URL url = new URL(reqURL);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("POST");
            conn.setRequestProperty("Authorization", "Bearer " + token);

            int responseCode = conn.getResponseCode();
            System.out.println("responseCode : " + responseCode);

            BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));

            String result = "";
            String line = "";

            while ((line = br.readLine()) != null) {
                result += line;
            }
            System.out.println(result);
        } catch (IOException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
	}

}
