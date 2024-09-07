package com.pro.sync.alarm.service;

import java.util.List;

import com.pro.sync.alarm.vo.AlarmVo;

public interface IAlarmService {
	List<AlarmVo> getUnreadAlarms(String emp_id);
	int getUnreadAlarmCnt(String emp_id);
	void isRead(String alarm_id);

}
