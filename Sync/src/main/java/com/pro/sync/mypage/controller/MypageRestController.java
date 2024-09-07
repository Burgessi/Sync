package com.pro.sync.mypage.controller;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletContext;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.util.WebUtils;

import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.mypage.service.IMypageService;
import com.pro.sync.mypage.vo.AccountVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
public class MypageRestController {

	@Autowired
	IMypageService service;

	@Autowired
    private ServletContext servletContext; // ServletContext 주입
	
	@Autowired
	private PasswordEncoder passwordEncoder;
	
	// 개인정보 수정 - 이메일/주소
	@PostMapping("/updateMyInfo.do")
	public ResponseEntity<String> UpdateEmailAddr(@RequestParam Map<String, Object> map,
			@SessionAttribute("loginDto") EmployeeVo loginDto, HttpServletRequest request) {
		log.info("{}", map);

		// 이메일 조합
		String emailId = (String) map.get("emailId");
		String emailDomain = (String) map.get("emailDomain");
		String customDomain = (String) map.get("customDomain");

		// 도메인 결정 (customDomain이 우선)
		String domain = (customDomain != null && !customDomain.isEmpty()) ? customDomain : emailDomain;
		String empEmail = emailId + "@" + domain;

		// 전화번호 조합
		String phone1 = (String) map.get("phone1");
		String phone2 = (String) map.get("phone2");
		String phone3 = (String) map.get("phone3");
		String empPhone = phone1 + phone2 + phone3;

		// 조합한 값을 map에 추가
		map.put("emp_email", empEmail);
		map.put("emp_phone", empPhone);

		map.put("emp_id", loginDto.getEmp_id());

		log.info("{}", map);

		// 데이터 업데이트 처리
		try {
			service.updateEmailAddr(map);
			return ResponseEntity.ok("Update successful");
		} catch (Exception e) {
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Update failed");
		}

	}

	// 개인정보 수정 - 급여 계좌
	@PostMapping("/updateMyAccount.do")
	public ResponseEntity<String> UpdateAccount(@RequestParam Map<String, Object> map,
			@SessionAttribute("loginDto") EmployeeVo loginDto, HttpServletRequest request) {
		log.info("{}", map);
		// emp_id 는 ㄱ로그인세션에서 가져오기
		// customBankName의 값을 bank_name으로 대체
		if ("custom".equals(map.get("bank_name"))) {
			map.put("bank_name", map.get("customBankName"));
		}

		// 은행 이름을 받아온 후 사용
		String bankName = (String) map.get("bank_name");
		String accountNum = (String) map.get("account_num");
		String accountHolder = (String) map.get("account_holder");
		String relationToEmp = (String) map.get("relation_to_emp");

		// 세션에서 로그인 정보 가져오기
		String emp_id = loginDto.getEmp_id();

		// 계좌 정보 조회
		AccountVo accDto = service.getAccountInfo(emp_id);

		if (accDto != null) {
			// 계좌 정보가 존재하면 업데이트
			accDto.setBank_name(bankName);
			accDto.setAccount_num(accountNum);
			accDto.setAccount_holder(accountHolder);
			accDto.setRelation_to_emp(relationToEmp);

			log.info("{}", accDto);
			service.updateAccount(accDto);
			return ResponseEntity.ok("Account updated successfully.");
		} else {
			// 계좌 정보가 존재하지 않으면 새로 생성하여 삽입
			AccountVo newAccDto = new AccountVo();
			newAccDto.setBank_name(bankName);
			newAccDto.setAccount_num(accountNum);
			newAccDto.setAccount_holder(accountHolder);
			newAccDto.setRelation_to_emp(relationToEmp);
			newAccDto.setEmp_id(emp_id);
			log.info("{}", newAccDto);
			service.insertAccount(newAccDto);
			return ResponseEntity.ok("Account created successfully.");
		}

	}

	// 개인정보 수정 - 비밀번호
	@PostMapping("/updateMyPassword.do")
	public ResponseEntity<String> updatePassword(@RequestParam Map<String, Object> map,
			@SessionAttribute("loginDto") EmployeeVo loginDto, HttpServletRequest request) {
		log.info("{}", map);
		// {newPassword=Rnrnfma22, confirmPassword=Rnrnfma22}

		String newPw = (String) map.get("confirmPassword");
		String encodedPassword = passwordEncoder.encode(newPw);
		map.put("emp_password", encodedPassword);

		// 세션에서 로그인 정보 가져오기
		if (loginDto == null) {
			return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("User not logged in.");
		}

		map.put("emp_id", loginDto.getEmp_id());
		log.info("{}", map);

		// 데이터 업데이트 처리
		try {
			service.updatePassword(map);
			return ResponseEntity.ok("Update successful");
		} catch (Exception e) {
			log.error("Error occurred while updating password", e); // 예외 로그 추가
			return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR).body("Update failed");
		}
	}

	
	
	@PostMapping("/updateProfilePic.do")
	public ResponseEntity<Map<String, String>> updateProfilePic(
	        @RequestParam("profilePic") MultipartFile file,
	        @SessionAttribute("loginDto") EmployeeVo loginDto) throws IOException {

	    if (loginDto == null) {
	        return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body(Map.of("msg", "User not logged in."));
	    }

	    if (file.isEmpty()) {
	        return ResponseEntity.badRequest().body(Map.of("msg", "파일이 업로드되지 않았습니다"));
	    }

	    // 서버의 파일 저장 경로를 가져옵니다.
	    String uploadDir = servletContext.getRealPath("/resources/upload/profile");
	    File uploadDirFile = new File(uploadDir);
	    if (!uploadDirFile.exists()) {
	        uploadDirFile.mkdirs(); // 디렉토리가 없으면 생성합니다.
	    }

	    String originFileName = file.getOriginalFilename();
	    String saveFileName = UUID.randomUUID().toString()
	            .concat(originFileName.substring(originFileName.lastIndexOf(".")));
	    File saveFile = new File(uploadDirFile, saveFileName);

	    try (InputStream inputStream = file.getInputStream();
	         OutputStream outputStream = new FileOutputStream(saveFile)) {
	        byte[] buffer = new byte[1024];
	        int bytesRead;
	        while ((bytesRead = inputStream.read(buffer)) != -1) {
	            outputStream.write(buffer, 0, bytesRead);
	        }
	    }

	    // 데이터베이스 업데이트
	    String contextPath = servletContext.getContextPath();
	    String fileUrl = contextPath + "/resources/upload/profile/" + saveFileName;
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("emp_id", loginDto.getEmp_id());
	    paramMap.put("emp_profile_pic", fileUrl);
	    service.updateProfilepic(paramMap);

	    Map<String, String> response = new HashMap<>();
	    response.put("msg", "프로필 사진이 변경되었습니다");
	    response.put("fileUrl", fileUrl);
	    log.info(fileUrl);

	    return ResponseEntity.ok(response);
	}

}
