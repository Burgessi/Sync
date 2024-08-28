package com.pro.sync.mypage.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.employee.vo.OffVo;
import com.pro.sync.mypage.service.IMypageService;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MypageController {
	
	@Autowired
	IMypageService service;

	@GetMapping("/mypage.do")
	public String Mypage(HttpSession session, Model model) {
		log.info("mypage 이동");
		
		EmployeeVo loginDto = (EmployeeVo) session.getAttribute("loginDto");
		
		if(loginDto != null) {
			String emp_id = loginDto.getEmp_id();
			int usedOff = service.getUsedOff(emp_id);
			loginDto.setUsed_off(usedOff);
			List<OffVo> offVo = service.getOffHistory(emp_id);
			model.addAttribute("offVo",offVo);
		}
		return "mypage/mypage";
	}
	

}
