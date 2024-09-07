package com.pro.sync.alarm.dao;

import java.util.List;

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
	public List<AlarmVo> getUnreadAlarms(String emp_id) {
		
		return session.selectList(NS+"getUnreadAlarms",emp_id);
	}
	
	@Override
	public int getUnreadAlarmCnt(String emp_id) {
		
		return session.selectOne(NS+"getUnreadAlarmsCnt", emp_id);
	}
	
	@Override
	public void updateStatus(String alarm_id) {
		
		session.update(NS+"updateStatus", alarm_id);
	}
}
