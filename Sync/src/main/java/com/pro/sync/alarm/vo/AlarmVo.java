package com.pro.sync.alarm.vo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
public class AlarmVo {
	
	private String alarm_id;
	private String receiver_id;
	private String alarm_type;
	private String title;
	private String content;
	private String status; //read unread
	private String create_at; //알림 생성 시간
	private String timeAgo; // 몇 분 전에 왔는지
	private int bd_seq;
}
