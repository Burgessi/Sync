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
}
