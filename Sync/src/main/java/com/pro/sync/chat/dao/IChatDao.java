package com.pro.sync.chat.dao;

import java.util.List;
import java.util.Map;

import com.pro.sync.chat.vo.ChatRoomParticipantsVo;
import com.pro.sync.chat.vo.ChatRoomVo;
import com.pro.sync.chat.vo.ChatVo;

public interface IChatDao {

	public int createChatRoom(ChatRoomVo chatRoomVo);
	
	public int participateInChatRoom(ChatRoomParticipantsVo chatRoomParticipantsVo);
	
	public int sendMessage(ChatVo chatVo);
	
	public List<ChatRoomVo> getAllChatList(String emp_id);
	
	public List<ChatVo> getAllChatContent(int chatroom_id);

	public int updateLatestMessage(ChatRoomVo roomVo);
	
	public int exitChatRoom(Map<String, String> info);
	
}
