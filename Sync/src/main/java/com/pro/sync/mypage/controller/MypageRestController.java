package com.pro.sync.mypage.controller;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.pro.sync.mypage.service.IMypageService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import java.util.Map;

@RestController
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/mypage")
public class MypageRestController {

    private final IMypageService service;

    @PostMapping("/updateMyInfo")
    public ResponseEntity<?> updateMyInfoAJAX(@RequestParam Map<String, Object> params) {
        log.info("MypageRestController updateMyInfoAJAX 개인정보수정");
        log.info("전달받은 요청값 : {}", params);

        try {
            // 서비스 호출
            int result = service.updateMyInfo(params);

            // 결과에 따른 응답 반환
            if (result > 0) {
                return ResponseEntity.ok().body("{\"success\": true}");
            } else {
                return ResponseEntity.status(HttpStatus.BAD_REQUEST).body("{\"success\": false, \"message\": \"정보 업데이트 실패\"}");
            }
        } catch (Exception e) {
            log.error("정보 업데이트 중 오류 발생", e);
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("{\"success\": false, \"message\": \"서버 오류\"}");
        }
    }
}
