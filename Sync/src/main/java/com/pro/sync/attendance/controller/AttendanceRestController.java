package com.pro.sync.attendance.controller;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.pro.sync.attendance.service.IAttendanceService;

@CrossOrigin(origins = "*")
@RestController
public class AttendanceRestController {

	@Autowired
	IAttendanceService service;
	
	
	
	@PostMapping("/check-in.do")
    public ResponseEntity<String> checkIn(@RequestBody Map<String, String> payload) {
        String emp_id = payload.get("emp_id");
        System.out.println(emp_id);
        try {
            if (service.isAlreadyCheckedIn(emp_id)) {
                return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).contentType(MediaType.APPLICATION_JSON_UTF8).body("이미 출근 처리되었습니다.");
            } else {
                service.insertCheckIn(emp_id);
                String checkInTime = service.getCheckInTime(emp_id);
                System.out.println("getCheckInTime(emp_id)"+checkInTime);
                return ResponseEntity.ok(checkInTime);
            }
        } catch (Exception e) {
        	System.err.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).contentType(MediaType.APPLICATION_JSON_UTF8).body("출근 처리에 실패했습니다.");
        }
    }
	@PostMapping("/check-out.do")
	public ResponseEntity<String> checkOut(@RequestBody Map<String, String> payload) {
        String emp_id = payload.get("emp_id");

        try {
            if (service.isAlreadyCheckedIn(emp_id)) {//출근기록되어있으면
                String checkOutTime = service.getCheckOutTime(emp_id);
                
                
                //퇴근기록이 null일때 > 기록해주고
                if(checkOutTime == null) {
                	
                	checkOutTime = service.getCheckOutTime(emp_id);
//                	String work_duration = payload.get("work_duration");
                    Map<String, Object> map = new HashMap<String, Object>();
                    map.put("emp_id", emp_id);
//                    map.put("work_duration", work_duration);
                    System.out.println(map);
                    service.updateCheckOut(map);
                    //퇴근시각 업데이트 후 근무시간 업데이트
                    service.updateWorkDuration(emp_id);
                	return ResponseEntity.ok(checkOutTime);
                }
                else {//퇴근기록 null아닐때.있을 때. 실패
                	return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).contentType(MediaType.APPLICATION_JSON_UTF8).body("이미 퇴근 처리되었습니다.");
                }
            } else {//출근기록 없으면
            	return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).contentType(MediaType.APPLICATION_JSON_UTF8).body("출근 기록이 없습니다.");
            }
        } catch (Exception e) {
        	System.err.println(e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).contentType(MediaType.APPLICATION_JSON_UTF8).body("퇴근 처리에 실패했습니다.");
        }
    }

    @GetMapping("/get-check-in-time.do")
    public ResponseEntity<String> getCheckInTime(@RequestParam("emp_id") String emp_id) {
        try {
            String checkInTime = service.getCheckInTime(emp_id);
            if (checkInTime != null) {
                return ResponseEntity.ok(checkInTime);
            } else {
                return ResponseEntity.noContent().build();
            }
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("출근 시각 조회에 실패했습니다.");
        }
    }
    @GetMapping("/get-check-out-time.do")
    public ResponseEntity<Map<String, String>> getCheckOutTime(@RequestParam("emp_id") String emp_id) {
        try {
            String checkOutTime = service.getCheckOutTime(emp_id);
            String workDuration = service.getWorkDuration(emp_id); // 총 근무 시간 조회

            Map<String, String> response = new HashMap<>();
            response.put("checkOutTime", checkOutTime != null ? checkOutTime : "-");
            response.put("workDuration", workDuration != null ? workDuration : "-");

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body(Map.of("error", "퇴근 시각 및 총 근무 시간 조회에 실패했습니다."));
        }
    }

	@GetMapping("/getWeeklyWorkDuration.do")
	public Map<String, Object> getWeeklyWorkDuration(@RequestParam("emp_id") String emp_id){
		String weekDurationSeconds = service.getWeekDuration(emp_id);
		 Map<String, Object> response = new HashMap<>();
	     response.put("weekDurationSeconds", weekDurationSeconds);
	     System.out.println(response);
	     return response;
	}
	@GetMapping("/getMonthlyWorkDuration.do")
	public Map<String, Object> getMonthlyWorkDuration(@RequestParam("emp_id") String emp_id){
		String monthDurationSeconds = service.getMonthDuration(emp_id);
		Map<String, Object> response = new HashMap<>();
		response.put("monthDurationSeconds", monthDurationSeconds);
		System.out.println(response);
		return response;
	}
	
	@GetMapping("/getServerTime.do")
    public Map<String, String> getServerTime() {
        Map<String, String> response = new HashMap<>();
        LocalDateTime serverTime = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        response.put("serverTime", serverTime.format(formatter));
        return response;
    }
//	public ResponseEntity<String> updateCheckOut(@RequestBody Map<String, String> payload) {
//		String emp_id = payload.get("emp_id");
//		try {
//			service.updateCheckOut(emp_id);
//			return ResponseEntity.ok("Check-out successful");
//		} catch (Exception e) {
//			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Error during check-out");
//		}
//	}
}
