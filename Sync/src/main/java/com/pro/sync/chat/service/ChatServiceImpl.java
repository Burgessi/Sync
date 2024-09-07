package com.pro.sync.chat.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pro.sync.chat.dao.IChatDao;
import com.pro.sync.chat.vo.ChatRoomParticipantsVo;
import com.pro.sync.chat.vo.ChatRoomVo;
import com.pro.sync.chat.vo.ChatVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements IChatService {

	private final IChatDao dao;

	@Override
	@Transactional
	public int createChatRoom(String chatroom_name, List<String> empIds) {
		
		ChatRoomVo chatRoomVo = new ChatRoomVo();
		ChatRoomParticipantsVo chatRoomParticipantsVo = new ChatRoomParticipantsVo();
		
		
		//생성할 채팅방 이름
		chatRoomVo.setChatroom_name(chatroom_name);
		dao.createChatRoom(chatRoomVo);
		
		//insert후 반환된 chatroom_id 이용하기 - selectKey
		chatRoomParticipantsVo.setChatroom_id(chatRoomVo.getChatroom_id());
		
		//사원수 모두 insert
		for (String id : empIds) {
			chatRoomParticipantsVo.setParticipant_id(id);
			dao.participateInChatRoom(chatRoomParticipantsVo);
		}
		
		return chatRoomVo.getChatroom_id();
	}

	@Override
	@Transactional
	public int sendMessage(ChatVo chatVo) {
		ChatRoomVo roomVo = new ChatRoomVo();
		
		//채팅 내용 insert이후 chatroom_id 리턴
		dao.sendMessage(chatVo);
		
		roomVo.setLatest_chat_id(chatVo.getChat_id());
		roomVo.setLatest_message_content(chatVo.getContent());
		roomVo.setChatroom_id(chatVo.getChatroom_id());
		
		//마지막 채팅내용을 업데이트
		return dao.updateLatestMessage(roomVo);
	}

	@Override
	public List<ChatRoomVo> getAllChatList(String emp_id) {
		return dao.getAllChatList(emp_id);
	}

	@Override
	public List<ChatVo> getAllChatContent(int chatroom_id) {
		return dao.getAllChatContent(chatroom_id);
	}

	@Override
	public int exitChatRoom(Map<String, String> info) {
		return dao.exitChatRoom(info);
	}

	@Override
	public int inviteToChatRoom(Map<String, Object> info) {
		return dao.inviteToChatRoom(info);
	}

}
