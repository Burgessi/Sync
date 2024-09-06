package com.pro.sync.chat.controller;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.pro.sync.chat.service.IChatService;
import com.pro.sync.chat.vo.ChatVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/chat")
public class ChatRestController {

	private final IChatService chatService;
	
	
	//채팅방 생성
	@PostMapping("/createChatRoom.do")
	public int createChatRoom(@RequestParam("emp_id") List<String> empIds, String chatroom_name) {
		
		log.info("채팅방 생성 createChatRoom : 받은 값 {}, {}", chatroom_name, empIds);
		
		int chatroomid = chatService.createChatRoom(chatroom_name, empIds);
		
		return chatroomid;
	}
	
	
	//메세지 전송
	@PostMapping("/sendMessage.do")
	public String sendMessage(String chat_sender, String chatroom_id, String content) {
		log.info("chat_sender: {}", chat_sender);
		log.info("chatroom_id: {}", chatroom_id);
		log.info("content: {}", content);
		ChatVo chat = new ChatVo();
		chat.setChatroom_id(Integer.parseInt(chatroom_id));
		chat.setChat_sender(chat_sender);
		chat.setContent(content);
		chatService.sendMessage(chat);
		return "true";
	}
	
	//채팅방 삭제
	@GetMapping("/exitChatRoom.do")
	public String exitChatRoom(@RequestParam Map<String, String> info) {
		log.info("exitChatRoom 화면에서 받은 값: {}", info);
		chatService.exitChatRoom(info);
		return "true";
	}
	
	
	
}
