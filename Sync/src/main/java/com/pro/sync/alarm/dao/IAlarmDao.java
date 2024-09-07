package com.pro.sync.alarm.dao;

import java.util.List;

import com.pro.sync.alarm.vo.AlarmVo;

public interface IAlarmDao {
	
	List<AlarmVo> getUnreadAlarms(String emp_id);
	int getUnreadAlarmCnt(String emp_id);
	void updateStatus(String alarm_id);

}
