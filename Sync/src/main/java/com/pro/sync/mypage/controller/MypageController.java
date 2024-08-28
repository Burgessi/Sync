package com.pro.sync.mypage.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;


import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.mypage.service.IMypageService;
import com.pro.sync.mypage.vo.AccountVo;
import com.pro.sync.mypage.vo.OffVo;


import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MypageController {
	
	@Autowired
	IMypageService service;

	//마이페이지 이동 - 연차
	@GetMapping("/mypage.do")
	public String Mypage(@SessionAttribute("loginDto") EmployeeVo loginDto, 
			@SessionAttribute("infoDto") EmployeeVo infoDto, 
			@SessionAttribute("accDto") AccountVo accDto, 
			Model model) {
		log.info("mypage 이동");
		
		String emp_id = loginDto.getEmp_id();
		
		
		if(loginDto != null) {
			infoDto.setEmp_ssn(formatSSN(infoDto.getEmp_ssn()));
			int usedOff = service.getUsedOff(emp_id);
			infoDto.setUsed_off(usedOff);
			List<OffVo> offVo = service.getOffHistory(emp_id);
			model.addAttribute("offVo",offVo);
			
		}
		return "mypage/mypage";
	}
	

	
	//주민등록번호 하이픈, 별표 처리
	public String formatSSN(String ssn) {
	    if (ssn != null && ssn.length() == 13) {
	        return ssn.substring(0, 6) + "-" + ssn.substring(6,7)+"******";
	    } else {
	        return ssn;
	    }
	}
	

}
