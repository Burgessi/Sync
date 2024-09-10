package com.pro.sync.mail.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {
	 @Bean
	    public JavaMailSender mailSender() {
	        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
	        mailSender.setHost("smtp.naver.com"); // SMTP 서버 주소
	        mailSender.setPort(587); // SMTP 포트

	        mailSender.setUsername("wltn5868@naver.com"); // 이메일 계정
	        mailSender.setPassword("Rnrnfma22!"); // 이메일 비밀번호

	        Properties props = mailSender.getJavaMailProperties();
	        props.put("mail.transport.protocol", "smtp");
	        props.put("mail.smtp.auth", "true");
	        props.put("mail.smtp.starttls.enable", "false");
	        props.put("mail.debug", "true");
	        props.put("mail.smtp.ssl.protocols", "TLSv1.2");

	        return mailSender;
	    }
}
