package com.pro.sync.chat.socket;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.pro.sync.chat.service.IChatService;
import com.pro.sync.chat.vo.ChatVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component(value = "chatGr.do")
public class ChatHandler extends TextWebSocketHandler{

	@Autowired
	private IChatService chatService;
	
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
		String chatroomId = (String)chatSession.get("chatroomId");
		String empId = (String)chatSession.get("empId");
		String empName = (String)chatSession.get("empName");
		
		log.info("접속 session 개수: {}", list.size());
		log.info("접속 사원 채팅방id : {}", chatroomId);
		log.info("접속 사원 id : {}", empId);
		log.info("접속 사원 name : {}", empName);
		
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
		String chatroomId = (String)chatSession.get("chatroomId");
		String empId = (String)chatSession.get("empId");
		String empName = (String)chatSession.get("empName");
		
		
		//채팅방 생성시 알림
		//같은 그룹이라면 알림 메시지 전송
		if(msg.indexOf("#&chatroom_") != -1) {
			
			//모든 웹소켓세션들을 반복문을 통해 처리
			for (WebSocketSession ws : list) {
				Map<String, Object> sessionMap = ws.getAttributes();
				
				//모든 세션을 돌면서 그룹Id를 탐색
				String otherChatroom = (String)sessionMap.get("chatroomId");
				
				//메세지 보낸 세션의 채팅방이 같은 채팅방일때만
				if(chatroomId.equals(otherChatroom)) {
					ws.sendMessage(new TextMessage("#enter_채팅방이 생성되었습니다."));
				}
				
			}
			
			//퇴장 알림
		} else if(msg.indexOf("#exit_") != -1) {
			
			String name = msg.substring(msg.indexOf("_") + 1);
			
			log.info("퇴장알림 msg"+msg);
			log.info("퇴장알림 name"+msg);
			for (WebSocketSession ws : list) {
				Map<String, Object> sessionMap = ws.getAttributes();
				
				//모든 세션을 돌면서 그룹Id를 탐색
				String otherChatroom = (String)sessionMap.get("chatroomId");
				
				//메세지 보낸 세션의 채팅방이 같은 채팅방일때만
				if(chatroomId.equals(otherChatroom)) {
					ws.sendMessage(new TextMessage(msg +"님이 채팅방을 나갔습니다."));
					
//					ChatVo chatVo = new ChatVo();
//					chatVo.setChat_sender("exit");
//					chatVo.setChatroom_id(Integer.parseInt(chatroomId));
//					chatVo.setContent(name+"님이 채팅방을 나갔습니다.");
//					
//					chatService.sendMessage(chatVo);
				}
				
			}
			
			
			//내용 전달	
		} else {
			
			
			
			//메세지를 '아이디:' 기준으로 잘라서 아이디만 저장
			//ws.send(empId + ":" + $("#chatInput").val()); 화면에서 보낸 값
			String id = msg.substring(0, msg.indexOf(":")).trim();
			
			//모든 웹소켓세션들을 반복문을 통해 처리
			for (WebSocketSession ws : list) {
				
				Map<String, Object> sessionMap = ws.getAttributes();
				String otherChatroomId = (String)sessionMap.get("chatroomId");
				String otherEmpId = (String)sessionMap.get("empId");
				String otherEmpName = (String)chatSession.get("empName");
				
				//같은 채팅방이라면
				if(chatroomId.equals(otherChatroomId)) {
					
					//메세지 보낸 사람이 세션의 id와 같다면
					if(id.equals(otherEmpId)) {
						String newMsg = "[나]" + msg.replace(msg.substring(0, msg.indexOf(":")+1), "");
						log.info("내 메세지 내용 : {}", newMsg);
						txt = newMsg;
					
					//다르다면
					} else {
						
						log.info("다른 사람 메세지 내용: {}", msg);
						txt = otherEmpName + ":" + msg.substring(msg.indexOf(":")+1);
						
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
		String chatroomId = (String)chatSession.get("chatroomId");
		String empId = (String)chatSession.get("empId");
		String empName = (String)chatSession.get("empName");
		
		
		log.info("세션 삭제 전 {}," ,list.contains(session));
		list.remove(session);
		log.info("세션 삭제 후 {}", list.contains(session));
		
//		for (WebSocketSession s : list) {
//			Map<String, Object> sessionMap = s.getAttributes();
//			String otherChatroomId = (String)sessionMap.get("chatroomId");
//			if(chatroomId.equals(otherChatroomId)) {
//				
//				s.sendMessage(new TextMessage("<font style='color:#232323; size:5px'>"+empSessionName+"님이 퇴장했습니다.</font>"));
//			}
//		}
		
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
}
