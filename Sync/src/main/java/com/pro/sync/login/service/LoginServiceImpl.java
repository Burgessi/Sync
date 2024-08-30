package com.pro.sync.login.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.login.dao.ILoginDao;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class LoginServiceImpl implements ILoginService {
	
	@Autowired
	private ILoginDao dao;

	@Override
	public EmployeeVo getLogin(Map<String, Object> map) {
		log.info("로그인 서비스 : {}", map);
		return dao.getLogin(map);
	}
	
	@Override
	public int updatePwStatus(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.updatePwStatus(map);
	}

}
