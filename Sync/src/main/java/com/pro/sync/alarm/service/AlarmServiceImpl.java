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
	public int getUnreadAlarmCnt(String emp_id, String alarm_type) {
		
		Map<String, String> params = Map.of("emp_id", emp_id, "alarm_type", alarm_type);
		return dao.getUnreadAlarmCnt(params);
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
	    alarm.setTitle("댓글이 달렸습니다"); //이거 게시물 제목,,,으로
	    alarm.setContent(title + "에 새로운 댓글이 달렸습니다.");
	    alarm.setStatus("N");  //읽지 않은 상태
	    
	    
	    
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	    alarm.setCreate_at(LocalDateTime.now().format(formatter));  //String 타입으로 저장

	
	  dao.insertAlarm(alarm);

	}
	
	
	//결재 알림
	@Override
	public void addApprovalAlarm(Map<String, String> approval) {
		
		
		AlarmVo alarm = new AlarmVo();
		String receiver_id = (String)approval.get("emp_id");
		String document_type = (String)approval.get("document_type");
		String approval_status = (String)approval.get("approval_status");
		
		//결재승인시
		if(approval_status.equals("1")) {
			alarm.setReceiver_id(receiver_id);
		    alarm.setAlarm_type("A");
		    alarm.setTitle(document_type); 
		    alarm.setContent(document_type + "가 승인되었습니다.");
		    alarm.setStatus("N");  //읽지 않은 상태
		//결재반려시
		} else {
			alarm.setReceiver_id(receiver_id);
		    alarm.setAlarm_type("R");
		    alarm.setTitle(document_type); 
		    alarm.setContent(document_type + "가 반려되었습니다.");
		    alarm.setStatus("N");  //읽지 않은 상태
		}
		
		 DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		 alarm.setCreate_at(LocalDateTime.now().format(formatter));  //String 타입으로 저장
		    
		 dao.insertAlarm(alarm);
	}
	
}
