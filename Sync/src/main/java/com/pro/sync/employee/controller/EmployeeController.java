package com.pro.sync.employee.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pro.sync.employee.service.EmployeeService;
import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.mypage.service.IMypageService;
import com.pro.sync.mypage.vo.AccountVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
public class EmployeeController {

	private final EmployeeService employeeService;
	private final IMypageService mypageService;
	

//	@GetMapping(value = "/registForm.do")
//	public String regist() {
//		log.info("EmployeeController regist.do 사원 등록 화면 이동");
//		return "employee/registForm";
//	}

	@PostMapping(value = "/regist.do")
	public String regist(@ModelAttribute EmployeeVo employeeVo, HttpSession session,RedirectAttributes attributes) throws IOException {
		log.info("EmployeeController regist.do 사원 등록 완료 이동");
		log.info("전달받은 employeeVo : {}", employeeVo);

		// employeeVo 객체에서 SSN을 가져와서 '-' 문자를 제거한 후 다시 설정
		String ssn = employeeVo.getEmp_ssn();
		if (ssn != null) {
			ssn = ssn.replaceAll("-", "");
			employeeVo.setEmp_ssn(ssn);
		}

		int n = employeeService.insertEmployee(employeeVo);

		if (n == 1) {
			//session.setAttribute("toastMsg", "사원 등록 완료!");
			attributes.addFlashAttribute("message", "사원 등록 완료!");
			return "redirect:/employeeSelectAll.do";
			// 등록 후 목록 페이지로 리다이렉트
		} else {
//			session.setAttribute("toastMsg", "사원 등록 실패. 다시 시도해주세요");
			attributes.addFlashAttribute("message", "사원 등록 실패. 다시 시도해주세요");
			return "employee/registForm";
			// 등록 실패 시 등록 폼으로
		}
		
	}
	
	@PostMapping(value = "/updateEmployee.do")
	public String updateEmployee(@RequestParam Map<String, String> map, HttpSession session,RedirectAttributes attributes) {
	    log.info("EmployeeController updateEmployee.do 사원 수정 처리");
	    
//	    log.info("전달받은 empId : {}", empId);
	
	    map.remove("emp_name");
	    map.remove("division");
	    
//	    // empId가 employeeVo에 포함되어 있는지 확인 (혹은 employeeVo에 setEmpId 메서드를 호출하여 설정)

	    //employeeVo.setEmp_id(empId);

	    int n = employeeService.updateEmployee(map);

	    if (n == 1) {
	        //session.setAttribute("toastMsg", "사원 정보 수정 완료!");
	        attributes.addFlashAttribute("message", "사원 정보 수정 완료!");
	        return "redirect:/employeeSelectAll.do"; // 수정 후 목록 페이지로 리다이렉트
	    } else {
	        //session.setAttribute("toastMsg", "사원 정보 수정 실패. 다시 시도해주세요");
	    	attributes.addFlashAttribute("message", "사원 정보 수정 실패. 다시 시도해주세요");
	        return "redirect:/employeeSelectAll.do"; 
	    }
	}
	
	//새로 만든 컨트롤러
	@RequestMapping(value="/registForm.do", method=RequestMethod.GET)
	public String employeeInsertUpdate(@RequestParam(name="emp_id", required=false) String empId, Model model) {
			
		 try {
			if(StringUtils.isNotEmpty(empId)) {
				//empId가 있는 경우 수정 모드
				model.addAttribute("employee",employeeService.employeeSelectDetail(empId));
				model.addAttribute("isUpdate",true); //수정 모드 표시
			}else {
				//empId가 없는 경우 등록 모드
				model.addAttribute("employee", new EmployeeVo()); //빈 employeeVo 객체 전달
				model.addAttribute("isUpdate",false); //등록 모드 표시
			}
		 } catch (Exception e) {
		        e.printStackTrace();
		        log.error("오류");
		    }
		 return "/employee/registForm"; 
	}
	
	

	@GetMapping(value = "/employeeSelectAll.do")
	public String employeeSelectAll(Model model, @SessionAttribute("loginDto") EmployeeVo loginDto

		log.info("employeeSelectAll.do 사원 전체 조회");

		List<EmployeeVo> employeeList = employeeService.getAllEmployee();
		model.addAttribute("employeeList", employeeList);
		
//		String emp_id = loginDto.getEmp_id();
//		infoDto = mypageService.getInfo(emp_id);
//		session.setAttribute("infoDto", infoDto);

		return "employee/employeeList";
	}
	
	@GetMapping(value="/employeeSelectOne.do")
	public String employeeSelectOne(@RequestParam String emp_id, Model model) {
		log.info("employeeSelectOne.do 사원 상세 조회");
		
		EmployeeVo employeeVo = employeeService.employeeSelectDetail(emp_id);
		model.addAttribute("employeeVo",employeeVo);
		
		AccountVo accountVo= mypageService.getAccountInfo(emp_id);
		model.addAttribute("accountVo",accountVo);
				
				
//		log.info("가가가가가가{}",employeeVo);
		return "employee/employeeList";

	}
	
	
	

	@PostMapping(value = "/deleteEmployee.do")
	public String deleteEmployee(@RequestParam("emp_id") String emp_id, HttpSession session,RedirectAttributes attributes) {
	    log.info("EmployeeController deleteEmployee.do 사원 삭제 처리");
	    log.info("삭제할 사원 ID : {}", emp_id);
	    
	    // 현재 날짜를 "yyyyMMdd" 형식으로 가져옴
	    //String empLeavingDate = LocalDate.now().format(DateTimeFormatter.ofPattern("yyyy-MM-dd"));

	    int n = employeeService.deleteEmployee(emp_id);

	    if (n == 1) {
	        //session.setAttribute("toastMsg", "사원 삭제 완료!");
	    	 attributes.addFlashAttribute("message", "사원 퇴사 처리가 완료되었습니다");
	        return "redirect:/employeeSelectAll.do"; // 삭제 후 목록 페이지로 리다이렉트
	    } else {
	        //session.setAttribute("toastMsg", "사원 삭제 실패. 다시 시도해주세요");
	        attributes.addFlashAttribute("message", "사원 퇴사 처리 실패. 다시 시도해주세요");
	        return "employee/employeeSelectOne";
	    }
	}

}
