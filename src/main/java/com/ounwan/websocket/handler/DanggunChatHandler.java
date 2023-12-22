package com.ounwan.websocket.handler;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class DanggunChatHandler extends TextWebSocketHandler {

	List<WebSocketSession> sessionList = new ArrayList<>();

	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		sessionList.add(session);
		super.afterConnectionEstablished(session);
	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
		super.afterConnectionClosed(session, status);
	}

	// 클라이언트(브라우저)에서 서버로 메시지를 보냈을때
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		String strMessage = message.getPayload();

		SimpleDateFormat simpleDate = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		String strDate = simpleDate.format(new Date());
		strMessage += "|" + strDate;
		for (WebSocketSession webSocketSession : sessionList) {
			webSocketSession.sendMessage(new TextMessage(strMessage));
		}
		super.handleTextMessage(session, message);
	}

}
