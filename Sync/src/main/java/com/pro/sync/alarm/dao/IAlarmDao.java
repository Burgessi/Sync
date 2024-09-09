package com.pro.sync.alarm.dao;

import java.util.List;
import java.util.Map;

import com.pro.sync.alarm.vo.AlarmVo;

public interface IAlarmDao {
	
	List<AlarmVo> getUnreadAlarms(Map<String, String> params);
	int getUnreadAlarmCnt(Map<String, String> params);
	void updateStatus(String alarm_id);
	// 알림 삽입
    void insertAlarm(AlarmVo alarm);

}
