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
public class ChatVo {

	private int chat_id;
	private String content;
	private String sent_at;
	private int is_read;
	private String chat_sender;
	private String chat_sender_name;
	private String chat_receiver;
	private String chat_receiver_name;
	private int chatroom_id;

	private List<ChatRoomParticipantsVo> participants;
	
}
