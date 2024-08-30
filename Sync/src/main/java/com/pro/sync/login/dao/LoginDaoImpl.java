package com.pro.sync.login.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Repository
public class LoginDaoImpl implements ILoginDao {
	
	@Autowired
	private SqlSessionTemplate session;
	
	private final String NS = "com.pro.sync.login.dao.LoginDaoImpl.";
	
	// 로그인
	@Override
	public EmployeeVo getLogin(Map<String, Object> map) {
		log.info("LoginDaoImpl 로그인 : "+map);
		return session.selectOne(NS+"getLogin", map);
	}
	
	// 초기로그인 - 비밀번호,재직상태 변경
	@Override
	public int updatePwStatus(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return session.update(NS+"updatePwStatus", map);
	}
}
