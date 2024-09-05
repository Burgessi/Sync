package com.pro.sync.chat.vo;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@ToString
public class ChatRoomVo {

	private int chatroom_id;
	private String chatroom_name;
	private String create_at;
	private String delete_flag;
	private int latest_chat_id;
	private String latest_message_content;
	private String latest_message_sent_at;

	List<ChatRoomParticipantsVo> participants;
	
}
