package com.pro.sync.employee.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pro.sync.employee.service.IEmployeeService;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class EmployeeController {
	
	
	private final IEmployeeService employeeService;
	
	
	@GetMapping(value="/registForm.do")
	public String regist() {	
		log.info("EmployeeController regist.do 사원 등록 화면 이동");
		return "employee/registForm";
	}
	
	@PostMapping(value="/regist.do")
	public String regist(@ModelAttribute EmployeeVo employeeVo, HttpSession session) throws IOException {
		log.info("EmployeeController regist.do 사원 등록 완료 이동");
		log.info("전달받은 employeeVo : {}",employeeVo);
		
		// employeeVo 객체에서 SSN을 가져와서 '-' 문자를 제거한 후 다시 설정
	    String ssn = employeeVo.getEmp_ssn();
	    if (ssn != null) {
	        ssn = ssn.replaceAll("-", "");
	        employeeVo.setEmp_ssn(ssn);
	    }

		int n=employeeService.insertEmployee(employeeVo);
		
		if(n == 1) {
			session.setAttribute("toastMsg", "사원 등록 완료!");
			return "redirect:/employeeSelectAll.do"; 
			// 등록 후 목록 페이지로 리다이렉트
		}else {
			session.setAttribute("toastMsg", "사원 등록 실패. 다시 시도해주세요");
			return "employee/registForm";
			// 등록 실패 시 등록 폼으로
		}
		
}
	
	@GetMapping(value="/employeeSelectAll.do")
	public String employeeSelectAll(Model model) {
		log.info("employeeSelectAll.do 사원 전체 조회");
		
		List<EmployeeVo> employeeList=employeeService.employeeSelectAll();
		model.addAttribute("employeeList",employeeList);

	return "employee/employeeList";
	}
	
	

	
	
	
	

	
}
