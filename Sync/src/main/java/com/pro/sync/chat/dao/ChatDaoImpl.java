package com.pro.sync.chat.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.chat.vo.ChatRoomParticipantsVo;
import com.pro.sync.chat.vo.ChatRoomVo;
import com.pro.sync.chat.vo.ChatVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ChatDaoImpl implements IChatDao {

	private final SqlSessionTemplate sessionTemplate;
	
	private final String NS = "com.pro.sync.chat.dao.ChatDaoImpl.";
	
	@Override
	public int createChatRoom(ChatRoomVo chatRoomVo) {
		return sessionTemplate.update(NS+"createChatRoom", chatRoomVo);
	}

	@Override
	public int participateInChatRoom(ChatRoomParticipantsVo chatRoomParticipantsVo) {
		return sessionTemplate.update(NS+"participateInChatRoom", chatRoomParticipantsVo);
	}

	@Override
	public int sendMessage(ChatVo chatVo) {
		return sessionTemplate.update(NS+"sendMessage", chatVo);
	}

	@Override
	public List<ChatRoomVo> getAllChatList(String emp_id) {
		return sessionTemplate.selectList(NS+"getAllChatList", emp_id);
	}

	@Override
	public List<ChatVo> getAllChatContent(int chatroom_id) {
		return sessionTemplate.selectList(NS+"getAllChatContent", chatroom_id);
	}

	@Override
	public int updateLatestMessage(ChatRoomVo roomVo) {
		return sessionTemplate.update(NS+"updateLatestMessage", roomVo);
	}

	@Override
	public int exitChatRoom(Map<String, String> info) {
		return sessionTemplate.update(NS+"exitChatRoom", info);
	}

	@Override
	public int inviteToChatRoom(Map<String, String> info) {
		return sessionTemplate.update(NS+"inviteToChatRoom", info);
	}

}
