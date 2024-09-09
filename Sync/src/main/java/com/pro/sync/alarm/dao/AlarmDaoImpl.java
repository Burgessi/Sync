package com.pro.sync.alarm.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.alarm.vo.AlarmVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AlarmDaoImpl implements IAlarmDao {

	private final SqlSessionTemplate session;
	private final String NS ="com.pro.sync.alarm.dao.AlarmDaoImpl.";
	
	@Override
	public List<AlarmVo> getUnreadAlarms(Map<String, String> params) {
		
		return session.selectList(NS+"getUnreadAlarms",params);
	}
	
	@Override
	public int getUnreadAlarmCnt(String emp_id) {
		
		return session.selectOne(NS+"getUnreadAlarmCnt", emp_id);
	}
	
	@Override
	public void updateStatus(String alarm_id) {
		
		session.update(NS+"updateStatus", alarm_id);
	}
	
	@Override
	public void insertAlarm(AlarmVo alarm) {
		
		session.insert(NS + "insertAlarm", alarm);
		
	}
}
