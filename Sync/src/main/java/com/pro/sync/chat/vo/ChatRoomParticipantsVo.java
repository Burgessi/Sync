package com.pro.sync.chat.vo;

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
public class ChatRoomParticipantsVo {

	private int chatroom_participants_id;
	private int chatroom_id;
	private String participant_id;
	private String participant_name;
	private String participant_team_name;
	private String join_at;
	private String leave_at;
	private String emp_profile_pic;
	
	
}
