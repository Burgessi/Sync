package com.pro.sync.login.service;

import java.util.Map;

import com.pro.sync.employee.vo.EmployeeVo;

public interface ILoginService {

	public EmployeeVo getLogin(Map<String, Object> map);
	public int updatePwStatus(Map<String, Object> map);

	public EmployeeVo autenticate(String emp_id, String rawPassword);
	public EmployeeVo findByEmpId(String emp_id);
}
