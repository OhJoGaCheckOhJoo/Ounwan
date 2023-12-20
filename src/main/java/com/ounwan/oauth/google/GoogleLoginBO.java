package com.ounwan.oauth.google;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.message.BasicNameValuePair;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.HttpClient;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.HttpClientBuilder;

import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.ClientsService;

@Service
public class GoogleLoginBO {
	
	@Autowired
	ClientsService clientsService;
	
	private static final String CLIENT_ID = "594474085257-0pg7jm97n051b5ovuarfajot45ltge77.apps.googleusercontent.com";
	private static final String REDIRECT_URI = "http://localhost:9090/myapp/oauth/google";
	private static final String GOOGLE_TOKEN_URL = "https://oauth2.googleapis.com/token";
	private static final String CLIENT_SECRET = "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";
	
	
	public String getURL() {
		StringBuffer bf = new StringBuffer();
		bf.append("http://accounts.google.com/o/oauth2/v2/auth?client_id=")
			.append(CLIENT_ID).append("&redirect_uri=").append(REDIRECT_URI)
			.append("&response_type=code&scope=email profile");
		
		return bf.toString();
	}
	
	public String getRequest(String code) throws IOException {
		String reqURL = "https://www.googleapis.com/oauth2/v4/token";
		
		List<NameValuePair> postParam = new ArrayList<NameValuePair>();
		
		postParam.add(new BasicNameValuePair("grant_type", "authorization_code"));
		postParam.add(new BasicNameValuePair("client_id", CLIENT_ID));
		postParam.add(new BasicNameValuePair("client_secret", CLIENT_SECRET));
		postParam.add(new BasicNameValuePair("redirect_uri", REDIRECT_URI));
		postParam.add(new BasicNameValuePair("code", code));
 
		HttpClient client = HttpClientBuilder.create().build();
        HttpPost post = new HttpPost(reqURL);
        
        post.setEntity(new UrlEncodedFormEntity(postParam));
        
        HttpResponse response = client.execute(post);
        int responseCode = response.getStatusLine().getStatusCode();

        // JSON 형태 반환값 처리
        ObjectMapper mapper = new ObjectMapper();
        JsonNode resultNode = mapper.readTree(response.getEntity().getContent());
	
		return resultNode.get("access_token").toString();
	}
	
	public ClientsDTO getUserInfo(String accessToken) throws IOException {
		String RequestUrl = "https://www.googleapis.com/oauth2/v2/userinfo";
 
		HttpClient httpClient = HttpClientBuilder.create().build();
		HttpGet get = new HttpGet(RequestUrl);
		
		get.addHeader("Authorization", "Bearer " + accessToken); //token 넣기
		
		HttpResponse response = httpClient.execute(get);
        int responseCode = response.getStatusLine().getStatusCode();
         
        ObjectMapper mapper = new ObjectMapper();
        JsonNode resultNode = mapper.readTree(response.getEntity().getContent());
        
        String token = resultNode.get("id").asText();
        String email = resultNode.get("email").asText();
        String name = resultNode.get("name").asText();
        String profilePic = resultNode.get("picture").asText();
        
        ClientsDTO client = clientsService.checkGoogleToken(token);
        
        return (client != null) ? 
        		client : ClientsDTO.builder()
        							.email(email)
        							.name(name)
        							.socialId(token)
        							.socialType("GOOGLE")
        							.profileURL(profilePic)
        							.build();
	}
}
