package com.pro.sync.alarm.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.alarm.vo.AlarmVo;

public interface IAlarmService {
	//읽지 않은 알림 목록
	List<AlarmVo> getUnreadAlarms(Map<String, String> params);
	
	//읽지 않은 알림 개수
	int getUnreadAlarmCnt(String emp_id);
	
	//알림 읽음 처리
	void isRead(String alarm_id);
	
	//댓글 알림 추가
	void addCommentAlarm(String receiver_id, String title, int bd_seq);

	//결재 알림 추가
	void addApprovalAlarm(Map<String, String> approval);
	
}
