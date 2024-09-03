package com.pro.sync.chat.socket;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component(value = "chatGr.do")
public class ChatHandler extends TextWebSocketHandler{


	//websocket session 담는 객체
	private ArrayList<WebSocketSession> list;
	
	//생성자
	public ChatHandler() {
		list = new ArrayList<WebSocketSession>();
	}
	
	// 웹소켓에 세션 담기 -> ws.onopen
	@Override 
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		log.info("afterConnectionEstablished 접속 - session : {}", session.getId());
		super.afterConnectionEstablished(session);
		
		// 전체 접속자 list에 session을 추가함.
		list.add(session);
		
		// 접속자의 그룹ID와 사원ID 추출
		Map<String, Object> chatSession = session.getAttributes();
		String grSession = (String)chatSession.get("grId");
		String empSession = (String)chatSession.get("empId");
		
		log.info("접속 session 개수: {}", list.size());
		log.info("접속 사원 id : {}", empSession);
		log.info("접속 사원 그룹id : {}", grSession);
		
	}
	
	//웹소켓 메세지 전송 -> ws.onmessage
	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
		
		log.info("handleTextMessage 메세지 전송 요청 : {}", message.getPayload());
		// payload에 클라이언트로부터 전송된 메시지가 담겨 있음
		String msg = message.getPayload();
		String txt = "";
		
		// chatController에서 session에 입력 한 값
		Map<String, Object> chatSession = session.getAttributes();
		//현재 메세지를 보낸 그룹id, 사원id를 추출 후 각각 담아놓기.
		String empSessionId = (String)chatSession.get("empId");
		String empSessionName = (String)chatSession.get("empName");
		String grSessionId = (String)chatSession.get("grId");
		
		
		//채팅방 입장시 알림 메시지 -> 메세지에 #&nick이 포함되었다면 -> 입장메세지
		//같은 그룹이라면 알림 메시지 전송
		if(msg.indexOf("#&name_") != -1) {
			//모든 웹소켓세션들을 반복문을 통해 처리
			for (WebSocketSession ws : list) {
				Map<String, Object> sessionMap = ws.getAttributes();
				//모든 세션을 돌면서 그룹Id를 탐색
				String otherGrSession = (String)sessionMap.get("grId");
				//만약 현재 메세지를 보낸 사람이 같은 그룹이라면
				if(grSessionId.equals(otherGrSession)) {
					ws.sendMessage(new TextMessage("<font style='color:#223055; size:5px'>"+empSessionName+"님이 입장했습니다.</font>"));
				}
			}
			
			//내용 전달
		} else {
			
			//메세지를 '아이디:' 기준으로 잘라서 아이디만 저장
			String id = msg.substring(0, msg.indexOf(":")).trim();
			
			//모든 웹소켓세션들을 반복문을 통해 처리
			for (WebSocketSession ws : list) {
				Map<String, Object> sessionMap = ws.getAttributes();
				String otherGrSessionId = (String)sessionMap.get("grId");
				String otherEmpSessionId = (String)sessionMap.get("empId");
				 
				//채팅 보낸사람이 같은 그룹이라면 -> 같은 그룹임
				if(grSessionId.equals(otherGrSessionId)) {
					
					//메세지 보낸 사람이 세션의 id와 같다면
					if(id.equals(otherEmpSessionId)) {
						String newMsg = "[나]" + msg.replace(msg.substring(0, msg.indexOf(":")+1), "");
						log.info("내 메세지 내용 : {}", newMsg);
						txt = newMsg;
					
					//다르다면
					} else {
						log.info("다른 사람 메세지 내용: {}", msg);
						txt = msg.substring(msg.indexOf(":")+1);
					}
					ws.sendMessage(new TextMessage(txt));
					
				}
				
				
			}
			
		}
		
		
		super.handleTextMessage(session, message);
	}
	
	
	
	// ws.onclose 를 통해 세션 삭제
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		log.info("afterConnectionClosed 세션 삭제");
		
		super.afterConnectionClosed(session, status);
		Map<String, Object> chatSession = session.getAttributes();
		String grSessionId = (String)chatSession.get("grId");
		String empSessionId = (String)chatSession.get("empId");
		String empSessionName = (String)chatSession.get("empName");
		
		
		log.info("세션 삭제 전 {}," ,list.contains(session));
		list.remove(session);
		log.info("세션 삭제 후 {}", list.contains(session));
		
		for (WebSocketSession s : list) {
			Map<String, Object> sessionMap = s.getAttributes();
			String otherGrSession = (String)sessionMap.get("grId");
			if(grSessionId.equals(otherGrSession)) {
				s.sendMessage(new TextMessage("<font style='color:#232323; size:5px'>"+empSessionName+"님이 퇴장했습니다.</font>"));
			}
		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
