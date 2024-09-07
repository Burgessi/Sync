package com.pro.sync.alarm.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pro.sync.alarm.dao.IAlarmDao;
import com.pro.sync.alarm.vo.AlarmVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AlarmServiceImpl implements IAlarmService {
	
	
	private final IAlarmDao dao;
	
	@Override
	public List<AlarmVo> getUnreadAlarms(String emp_id) {
		
		return dao.getUnreadAlarms(emp_id);
	}
	
	@Override
	public int getUnreadAlarmCnt(String emp_id) {
		
		return dao.getUnreadAlarmCnt(emp_id);
	}
	
	@Transactional
	@Override
	public void isRead(String alarm_id) {
		
		dao.updateStatus(alarm_id);
		
	}
	

}
