package com.pro.sync.chat.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.chat.vo.ChatRoomParticipantsVo;
import com.pro.sync.chat.vo.ChatRoomVo;
import com.pro.sync.chat.vo.ChatVo;

public interface IChatService {

	
	public int createChatRoom(String chatroom_name, List<String> empIds);
	
	public int sendMessage(ChatVo chatVo);
	
	public List<ChatRoomVo> getAllChatList(String emp_id);
	
	public List<ChatVo> getAllChatContent(int chatroom_id);
	
	public int exitChatRoom(Map<String, String> info);
}
