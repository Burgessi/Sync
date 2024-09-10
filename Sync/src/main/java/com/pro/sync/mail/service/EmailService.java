package com.pro.sync.mail.service;

import java.security.SecureRandom;
import java.util.HashMap;
import java.util.Map;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.pro.sync.mypage.service.IMypageService;


@Service
public class EmailService {

	@Autowired
	private JavaMailSender mailSender;

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private IMypageService mService;
	
	public void sendPasswordResetEmail(String toEmail, String emp_id) {
        String subject = "[Sync] 임시 비밀번호 발급";
       //임시 비밀번호 생성 및 전송
        String tempPw = makeRandomPw(8);
        String text = "임시 비밀번호: " + tempPw;
        
        //임시 비밀번호 암호화
        String encodedTempPw = passwordEncoder.encode(tempPw);
        
        //map에 담아서 update
        Map<String, Object> map = new HashMap<>();
        map.put("emp_password", encodedTempPw);
        map.put("emp_id", emp_id);
        mService.updatePassword(map);
        
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(toEmail);
        message.setSubject(subject);
        message.setText(text);
        message.setFrom("wltn5868@naver.com");
        mailSender.send(message);
	}
	
	// 소문자, 대문자, 숫자를 포함한 문자열
    private static final String CHARACTERS = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
    
    // 비밀번호 생성 메서드
    public String makeRandomPw(int len) {
        // 비밀번호 길이 검증
        if (len <= 0) {
            throw new IllegalArgumentException("Password length must be greater than 0");
        }

        SecureRandom random = new SecureRandom(); // 보안적인 난수 생성기
        StringBuilder sb = new StringBuilder(len); // StringBuilder로 문자열 생성

        for (int i = 0; i < len; i++) {
            // CHARACTERS에서 무작위로 인덱스 선택
            int index = random.nextInt(CHARACTERS.length());
            // 선택된 인덱스의 문자 추가
            sb.append(CHARACTERS.charAt(index));
        }

        return sb.toString(); // 생성된 비밀번호 반환
    }
}
