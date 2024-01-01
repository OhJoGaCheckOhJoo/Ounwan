package com.ounwan.oauth.naver;

import java.io.IOException;
import java.sql.Date;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.json.simple.parser.ParseException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.util.StringUtils;

import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;
import com.ounwan.dto.ClientsDTO;
import com.ounwan.service.ClientsService;

@Component
public class NaverLoginBO {

	@Autowired
	ClientsService clientsService;
	
	private static final String CLIENT_ID = "00";
    private static final String CLIENT_SECRET = "00";
    private static final String REDIRECT_URI = "00";
    private static final String SESSION_STATE = "00";
    private final static String PROFILE_API_URL = "00";

	public String getAuthorizationUrl(HttpSession session) {
		String state = generateRandomString();
		setSession(session, state);

		OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).state(state) 
				.build(NaverLoginApi.instance());

		return oauthService.getAuthorizationUrl();
	}

	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException {
		String sessionState = getSession(session);
		if (StringUtils.pathEquals(sessionState, state)) {

			OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
					.callback(REDIRECT_URI).state(state).build(NaverLoginApi.instance());

			OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
			return accessToken;
		}
		return null;
	}

	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}

	private void setSession(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}

	private String getSession(HttpSession session) {
		return (String) session.getAttribute(SESSION_STATE);
	}

	public ClientsDTO getUserProfile(OAuth2AccessToken oauthToken) throws IOException, ParseException {

		OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).build(NaverLoginApi.instance());

		OAuthRequest request = new OAuthRequest(Verb.GET, PROFILE_API_URL, oauthService);
		oauthService.signRequest(oauthToken, request);

		ClientsDTO naverClient = parseApi(request.send().getBody());
		ClientsDTO dbClient = clientsService.checkNaverToken(naverClient.getSocialId());

		return (dbClient != null) ? dbClient : naverClient;
	}

	public ClientsDTO parseApi(String apiResult) throws ParseException {
		JSONParser parser = new JSONParser();
		Object obj = parser.parse(apiResult);

		JSONObject jsonObj = (JSONObject) obj;
		JSONObject response = (JSONObject) jsonObj.get("response");
		
		String birthday = (String) response.get("birthyear") + "-" + (String) response.get("birthday");

		return ClientsDTO.builder()
							.name((String) response.get("name"))
							.email((String) response.get("email"))
							.phone((String) response.get("mobile"))
							.birthday(Date.valueOf(birthday))
							.profileUrl((String) response.get("profile_image"))
							.socialId((String) response.get("id"))
							.socialType("NAVER")
							.build();
	}
}
