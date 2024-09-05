package com.pro.sync.plan.ctrl;


import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.sync.plan.service.IScheduleService;
import com.pro.sync.plan.vo.ScheduleVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/plan")
public class ScheduleController {
    
    private final IScheduleService service;

    //캘린더 페이지 이동 후 일정 뿌리기
    @GetMapping(value = "/calendar.do")
    public String calendar(Model model) {
    	log.info(" 리스트 값 : {}","calendar");
    	List<ScheduleVo> lists = service.selectScd();
    	model.addAttribute("lists",lists);
        return "plan/calendar";
    }

    //일정 등록 
    @PostMapping("/insertScd.do")
    public ResponseEntity<Map<String, Object>> insertScd(
            @RequestParam Map<String, String> params) {

    	log.info("뭘까요 : {}" ,params);
        ScheduleVo scheduleVo = new ScheduleVo();
        scheduleVo.setTeam_code(params.get("team_code"));
        scheduleVo.setEmp_name(params.get("emp_name"));

        DateTimeFormatter formatter = DateTimeFormatter.ISO_LOCAL_DATE_TIME;
        try {
            LocalDateTime startDateTime = LocalDateTime.parse(params.get("scd_start"), formatter);
            LocalDateTime endDateTime = LocalDateTime.parse(params.get("scd_end"), formatter);
            scheduleVo.setScd_start(startDateTime); 
            scheduleVo.setScd_end(endDateTime);     
        } catch (DateTimeParseException e) {
            // 예외 처리: 잘못된 날짜 형식
            e.printStackTrace();
            return ResponseEntity.badRequest().body(Map.of("error", "날짜 및 시간 형식이 잘못되었습니다."));
        }

        scheduleVo.setScd_title(params.get("scd_title"));
        scheduleVo.setScd_content(params.get("scd_content"));

        try {
            int result = service.addScd(scheduleVo);

            Map<String, Object> response = new HashMap<>();
            response.put("insertSkdCount", result);
            response.put("scd_no", scheduleVo.getScd_no());

            return ResponseEntity.ok(response);
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(500).body(Map.of("error", "일정 등록 중 오류가 발생했습니다."));
        }
    }
    
    //일정 상세보기
    @GetMapping(value = "/detailschedule.do")
    @ResponseBody
    public Map<String, String> detailScd(@RequestParam int scd_no) {
    	
    	
    	ScheduleVo schedule = service.detailScd(scd_no);  
    	
    	// 포맷터 설정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm");

        // LocalDateTime을 문자열로 변환
        String start = schedule.getScd_start() != null ? schedule.getScd_start().format(formatter) : null;
        String end = schedule.getScd_end() != null ? schedule.getScd_end().format(formatter) : null;

        Map<String, String> response = new HashMap<>();
        response.put("scd_no", String.valueOf(schedule.getScd_no()));
        response.put("emp_name", schedule.getEmp_name());
        response.put("scd_title", schedule.getScd_title());
        response.put("team_code", schedule.getTeam_code());
        response.put("team_name", schedule.getTeam_name());
        response.put("scd_start", start);
        response.put("scd_end", end);
        response.put("scd_content", schedule.getScd_content());
        log.info("response : {}", response);
        
    	return response;
    }
    
    //일정 삭제
    @PostMapping(value = "/delScd.do")
    @ResponseBody
    public int delScd(@RequestParam("scd_no") int scd_no){
    	return service.delScd(scd_no);
    }
    
}
