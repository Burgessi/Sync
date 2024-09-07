package com.pro.sync.login.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.login.dao.ILoginDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginServiceImpl implements ILoginService {
	
	@Autowired
	private ILoginDao dao;
	
	@Autowired
	private PasswordEncoder passwordEncoder;

	@Override
	public EmployeeVo getLogin(Map<String, Object> map) {
		log.info("로그인 서비스 : {}", map);
		return dao.getLogin(map);
	}
	
	@Override
	public int updatePwStatus(Map<String, Object> map) {
		return dao.updatePwStatus(map);
	}
	
//	//비밀번호 검증 및 로그인 처리
	@Override
	public EmployeeVo autenticate(String emp_id, String rawPassword) {
		 EmployeeVo user = dao.findByEmpId(emp_id);
	        if (user != null && passwordEncoder.matches(rawPassword, user.getEmp_password())) {
	            return user;
	        }
	        return null;
	}
	
	@Override
	public EmployeeVo findByEmpId(String emp_id) {
		return dao.findByEmpId(emp_id);
	}

}
