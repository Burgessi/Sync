package com.pro.sync.plan.ctrl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.pro.sync.plan.service.IScheduleService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequiredArgsConstructor
@RequestMapping("/plan")
public class ScheduleRestController {

    private final IScheduleService service;

    @PostMapping(value = "/modifyScd.do")
    @ResponseBody
    public boolean modifyschedule(@RequestParam Map<String, Object> map) {

        log.info("데이터 내놔!: {}", map);

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd'T'HH:mm");
           
            LocalDateTime start = LocalDateTime.parse((String) map.get("scd_start"), formatter);
            LocalDateTime end = LocalDateTime.parse((String) map.get("scd_end"), formatter);

            String scdNo = (String) map.get("scd_no");
            String title = (String) map.get("scd_title");
            String teamCode = (String) map.get("team_code");
            String artistId = (String) map.get("artist_id");
            String content = (String) map.get("scd_content");

            if (scdNo == null || title == null || teamCode == null || artistId == null || content == null) {
                log.error("필드 누락");
                return false;
            }

            map.put("scd_start", start);
            map.put("scd_end", end);

            boolean updateSuccess = service.updateScd(map);
            return updateSuccess;
       
    }
}
