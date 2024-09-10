package com.pro.sync.mail.controller;

import java.util.HashMap;
import java.util.Map;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.pro.sync.mail.service.EmailService;
import com.pro.sync.mypage.service.IMypageService;

@Controller
public class PasswordResetController {


	@Autowired
	private IMypageService mService;

	@Autowired
	private EmailService emailService;


	@PostMapping("/sendResetLink.do")
	public ModelAndView requestPasswordReset(@RequestParam String emp_id, @RequestParam String emp_email) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("emp_email", emp_email);
		map.put("emp_id", emp_id);
		int userExists = mService.checkUser(map);
		if (userExists == 1) {
			// 임시 비밀번호 발송
			emailService.sendPasswordResetEmail(emp_email, emp_id);

			return new ModelAndView("mypage/passwordResetRequestSuccess");
		} else {
			return new ModelAndView("mypage/passwordResetRequestFailure");
		}
	}

}
