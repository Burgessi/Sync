package com.pro.sync.alarm.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public List<AlarmVo> getUnreadAlarms(Map<String, String> params) {
		
		//Map<String, String> params = new HashMap<>();
		//params.put("emp_id", emp_id);
	    //params.put("alarm_type", alarm_type);
	    
		return dao.getUnreadAlarms(params);
	}
	
	@Override
	public int getUnreadAlarmCnt(String emp_id) {
		
		return dao.getUnreadAlarmCnt(emp_id);
	}
	
	//@Transactional
	@Override
	public void isRead(String alarm_id) {
		
		dao.updateStatus(alarm_id);
		
	}
	
	//댓글 알림
	@Override
	public void addCommentAlarm(String receiver_id, String title) { // 게시물 제목
	    AlarmVo alarm = new AlarmVo();
	    
	    alarm.setReceiver_id(receiver_id);
	    alarm.setAlarm_type("C");
	    alarm.setTitle(title); //이거 게시물 제목,,,으로
	    alarm.setContent(title + "에 새로운 댓글이 달렸습니다.");
	    alarm.setStatus("N");  //읽지 않은 상태
	    
	    
	    
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	    alarm.setCreate_at(LocalDateTime.now().format(formatter));  //String 타입으로 저장

	
	  dao.insertAlarm(alarm);

}
}
