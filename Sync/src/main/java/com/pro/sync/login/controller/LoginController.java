package com.pro.sync.login.controller;

import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.login.service.ILoginService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {

	@Autowired
	private ILoginService service;

	//로그인
	@PostMapping(value = "/login.do")
	public String login(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
		log.info("로그인 : {}", map);
		EmployeeVo loginDto = service.getLogin(map);
		
		System.out.println(loginDto);
		if (loginDto != null) { // 로그인 성공
			loginDto.setEmp_ssn(formatSSN(loginDto.getEmp_ssn()));
            session.setAttribute("loginDto", loginDto);
            model.addAttribute("loginDto",loginDto);
            return "common/main"; // 메인 페이지로 이동
        } else { // 로그인 실패
            model.addAttribute("loginFailed", true);
            return "common/login"; // 로그인 페이지로 다시 이동
        }
	}
	
	//로그아웃
	@GetMapping(value = "/")
	public String logout(HttpSession session) {
		session.invalidate();
		return "common/login";
	}
	
	public String formatSSN(String ssn) {
	    if (ssn != null && ssn.length() == 13) {
	        return ssn.substring(0, 6) + "-" + ssn.substring(6);
	    } else {
	        return ssn;
	    }
	}
	

}
