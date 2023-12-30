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
	
	// redirect_uri: 네이버 로그인 인증의 결과를 전달받을 콜백 URL(URL 인코딩). 애플리케이션을 등록할 때 Callback
	// state: 애플리케이션이 생성한 상태 토큰
	private static final String CLIENT_ID = "00";
    private static final String CLIENT_SECRET = "00";
    private static final String REDIRECT_URI = "00";
    private static final String SESSION_STATE = "00";
    /* 프로필 조회 API URL */
    private final static String PROFILE_API_URL = "00";

	/* 네이버 아이디로 인증 URL 생성 Method */
	public String getAuthorizationUrl(HttpSession session) {
		/* 세션 유효성 검증을 위하여 난수를 생성 */
		String state = generateRandomString();
		/* 생성한 난수 값을 session에 저장 */
		setSession(session, state);

		/* Scribe에서 제공하는 인증 URL 생성 기능을 이용하여 네아로 인증 URL 생성 */
		OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
				.callback(REDIRECT_URI).state(state) // 앞서 생성한 난수값을 인증 URL생성시 사용함
				.build(NaverLoginApi.instance());

		return oauthService.getAuthorizationUrl();
	}

	/* 네이버아이디로 Callback 처리 및 AccessToken 획득 Method */
	public OAuth2AccessToken getAccessToken(HttpSession session, String code, String state) throws IOException {

		/* Callback으로 전달받은 세선검증용 난수값과 세션에 저장되어있는 값이 일치하는지 확인 */
		String sessionState = getSession(session);
		if (StringUtils.pathEquals(sessionState, state)) {

			OAuth20Service oauthService = new ServiceBuilder().apiKey(CLIENT_ID).apiSecret(CLIENT_SECRET)
					.callback(REDIRECT_URI).state(state).build(NaverLoginApi.instance());

			/* Scribe에서 제공하는 AccessToken 획득 기능으로 네아로 Access Token을 획득 */
			OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
			return accessToken;
		}
		return null;
	}

	/* 세션 유효성 검증을 위한 난수 생성기 */
	private String generateRandomString() {
		return UUID.randomUUID().toString();
	}

	/* http session에 데이터 저장 */
	private void setSession(HttpSession session, String state) {
		session.setAttribute(SESSION_STATE, state);
	}

	/* http session에서 데이터 가져오기 */
	private String getSession(HttpSession session) {
		return (String) session.getAttribute(SESSION_STATE);
	}

	/* Access Token을 이용하여 네이버 사용자 프로필 API를 호출 */
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
