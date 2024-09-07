package com.pro.sync.login.dao;

import java.util.Map;

import com.pro.sync.employee.vo.EmployeeVo;

public interface ILoginDao {

	/**
	 * 로그인
	 * @param map emp_id, emp_password
	 * @return null 혹은 EmployeeVo 객체
	 */
	public EmployeeVo getLogin(Map<String, Object> map);
	
	/**
	 * 초기로그인 비밀번호 변경 및 상태 변경
	 * @param map emp_password, emp_id
	 * @return
	 */
	public int updatePwStatus(Map<String, Object> map);
	
	public EmployeeVo findByEmpId(String emp_id);
	
}
