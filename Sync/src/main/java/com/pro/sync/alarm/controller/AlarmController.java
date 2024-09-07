package com.pro.sync.alarm.controller;

import java.time.Duration;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.pro.sync.alarm.service.IAlarmService;
import com.pro.sync.alarm.vo.AlarmVo;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@Slf4j
@RequiredArgsConstructor
public class AlarmController {
		
	private final IAlarmService alarmService;
	
	//읽지 않은 알림 목록 json으로 반환
	@GetMapping(value="/alarmList.do")
	public List<AlarmVo> getUnreadAlarms(@SessionAttribute("loginDto") EmployeeVo loginDto){
		String emp_id=loginDto.getEmp_id();
		List<AlarmVo> alarms=alarmService.getUnreadAlarms(emp_id);
		
		
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm:ss");
	    //알림 시간을 몇 분 전 형식으로 계산, timeAgo에 저장
		 return alarms.stream().map(alarm -> {
			 
			// String 타입의 CREATE_AT을 LocalDateTime으로 변환
	            LocalDateTime created_at = LocalDateTime.parse(alarm.getCreate_at(), formatter);
	            long minutesAgo = Duration.between(created_at, LocalDateTime.now()).toMinutes();
	         
	            // 조건에 따라 시간 차이를 문자열로 변환하여 timeAgo 필드에 설정
	            if (minutesAgo < 60) {
	            	alarm.setTimeAgo(minutesAgo + "분 전");
	            } else if (minutesAgo < 1440) {  // 1440분 = 24시간
	                long hoursAgo = minutesAgo / 60;
	                alarm.setTimeAgo(hoursAgo + "시간 전");
	            } else {
	                long daysAgo = minutesAgo / 1440;
	                alarm.setTimeAgo(daysAgo + "일 전");
	            }
	            return alarm;
	        }).collect(Collectors.toList());		 
		 }
	
	//읽지 않은 알림 개수
    @GetMapping(value="/alarmCnt.do")
    public int getUnreadNotificationCount(@SessionAttribute("loginDto") EmployeeVo loginDto) {
        String emp_id = loginDto.getEmp_id();
        return alarmService.getUnreadAlarmCnt(emp_id);
    }

    //알림을 읽음 처리
    @PostMapping("/alarmRead/{alarm_id}")
    public void alarmIsRead(@PathVariable("alarm_id") String alarm_id) {
    	alarmService.isRead(alarm_id);
    }
	
	
	
	}
	
	


