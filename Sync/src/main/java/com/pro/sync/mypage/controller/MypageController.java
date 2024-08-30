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
//			@SessionAttribute("accDto") AccountVo accDto, 
			Model model,
			HttpSession session) {
		log.info("mypage 이동");
		
		String emp_id = loginDto.getEmp_id();
		
		//세션에 담긴 infoDto가 바뀌면 세션을 세션을 갱신해야함!!!
		
		if(loginDto != null) {
			//정보 dto, 계좌 dto 가져오는부분
			//세션에 담겼던 infoDto, accDto 변경된다면 다시 select 실행해 정보를 담아주어야 함
    		infoDto = service.getInfo(emp_id);
    		
    		/*
    		 * 0829
    		 *  @SessionAttribute("accDto") AccountVo accDto삭제, AccountVo accDto = new AccountVo(); 추가
    		 * 계좌정보 없을 경우 세션에서 accDto 가져와도 null이면 예외 발생 가능
    		 * -> AccountVo 객체 생성 후 getAccountInfo로 정보 넣어주고 세션or모델에 담아서 사용
    		 */
    		AccountVo accDto = new AccountVo(); 
    		accDto = service.getAccountInfo(emp_id);
    		
    		int usedOff = service.getUsedOff(emp_id);
			infoDto.setUsed_off(usedOff);
			
			//연차 내역 vo
			List<OffVo> offVo = service.getOffHistory(emp_id);
			model.addAttribute("offVo",offVo);
			
			//새로운 정보가 담긴 Dto 다시 세션에 담아 갱신
    		session.setAttribute("infoDto", infoDto);
    		session.setAttribute("accDto", accDto);
    		
			
		}
		return "mypage/mypage";
	}
	

	
	//주민등록번호 하이픈, 별표 처리
//	public String formatSSN(String ssn) {
//	    if (ssn != null && ssn.length() == 13) {
//	        return ssn.substring(0, 6) + "-" + ssn.substring(6,7)+"******";
//	    } else {
//	        return ssn;
//	    }
//	}
	

}
