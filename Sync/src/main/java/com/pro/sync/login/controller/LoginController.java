package com.pro.sync.login.controller;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.pro.sync.common.aop.UpdateSession;
import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.login.service.ILoginService;
import com.pro.sync.mypage.service.IMypageService;
import com.pro.sync.mypage.vo.AccountVo;
import com.pro.sync.notice.service.INoticeService;
import com.pro.sync.notice.vo.NoticeVo;
import com.pro.sync.plan.service.IScheduleService;
import com.pro.sync.plan.vo.ScheduleVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LoginController {

	@Autowired
	private ILoginService service;

	@Autowired
	private IMypageService mservice;

	@Autowired
	private INoticeService nservice;

	@Autowired
	private IScheduleService sService;

//	@Autowired
//	private PasswordEncoder passwordEncoder;

//암호화 이후 로그인 	
//	@PostMapping("login.do")
//	public String login(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
//		//전달받은 map에 emp_id emp_password
//		String emp_id = (String) map.get("emp_id");
//		String rawpassword = (String) map.get("emp_password");
//		
////		EmployeeVo user = service.findByEmpId(emp_id);
//		EmployeeVo loginDto = service.autenticate(emp_id, rawpassword);
//		
//		if (loginDto != null) { // 로그인 성공
//            session.setAttribute("loginDto", loginDto);
////            String emp_id = loginDto.getEmp_id();
//
//            // 정보 dto, 계좌 dto 가져오는 부분
//            EmployeeVo infoDto = mservice.getInfo(emp_id);
//            AccountVo accDto = mservice.getAccountInfo(emp_id);
//
//            model.addAttribute("loginDto", loginDto);
//            session.setAttribute("infoDto", infoDto);
//            session.setAttribute("accDto", accDto);
//
//            model.addAttribute("infoDto", infoDto);
//
//            return "redirect:/main.do"; // 메인 페이지로 이동
//        } else { // 로그인 실패
//            model.addAttribute("loginFailed", true);
//            return "common/login"; // 로그인 페이지로 다시 이동
//        }
//	}
	
	// 로그인
		@PostMapping(value = "/login.do")
		public String login(@RequestParam Map<String, Object> map, HttpSession session, Model model) {
			log.info("로그인 : {}", map);
			EmployeeVo loginDto = service.getLogin(map);

			System.out.println(loginDto);
			if (loginDto != null) { // 로그인 성공
				//흠냐,,
				System.out.println(loginDto.getEmp_password());
				
				session.setAttribute("loginDto", loginDto);
				String emp_id = loginDto.getEmp_id();
				// 정보 dto, 계좌 dto 가져오는부분
				EmployeeVo infoDto = mservice.getInfo(emp_id);
				AccountVo accDto = mservice.getAccountInfo(emp_id);

				model.addAttribute("loginDto", loginDto);
				// 세션에 info,acc정보 담아줌
				session.setAttribute("infoDto", infoDto);
				session.setAttribute("accDto", accDto);
				
				model.addAttribute("infoDto", infoDto);

				return "redirect:/main.do"; // 메인 페이지로 이동
			} else { // 로그인 실패
				String emp_id = (String)map.get("emp_id");
				EmployeeVo user = service.findByEmpId(emp_id);
				System.out.println("qlqjs" + user.getEmp_password());
				model.addAttribute("loginFailed", true);
				return "common/login"; // 로그인 페이지로 다시 이동
			}
		}

	// 로그아웃
	@GetMapping(value = "/")
	public String logout(HttpSession session) {
		session.invalidate();
		return "common/login";
	}

	// 초기로그인 - 비밀번호 변경 > 승인대기->재직중으로 상태 변경
	@PostMapping("/changePassword.do")
	public String updateStatus(@RequestParam Map<String, Object> map, @SessionAttribute("loginDto") EmployeeVo loginDto,
			@SessionAttribute("infoDto") EmployeeVo infoDto, HttpSession session) {
		log.info("{}", map);// {newPassword=Aaaa1111, confirmPassword=Aaaa1111}

		if (loginDto != null) {
			String newPw = (String) map.get("confirmPassword");
			map.put("emp_password", newPw);
			String emp_id = loginDto.getEmp_id();
			map.put("emp_id", emp_id);
			service.updatePwStatus(map);

			infoDto = mservice.getInfo(emp_id);
			// 바뀐 정보를 가지고 있도록 세션 갱신
			session.setAttribute("infoDto", infoDto);
		}

		return "/common/login";
	}

	// 비밀번호 재설정 페이지 요청
	@GetMapping("/resetPw.do")
	public String resetPw() {
		return "/mypage/resetPw";
	}

	// 메인페이지 요청
	@UpdateSession
	@GetMapping("/main.do")
	public String getMain(Model model) {
		List<NoticeVo> noList = nservice.mainNotice();
		List<ScheduleVo> sList = sService.selectScd();
		model.addAttribute("noList", noList);
		model.addAttribute("sList", sList);
		log.info("noList : {}", noList);
		log.info("sList : {}", sList);
		return "/common/main";
	}

}
