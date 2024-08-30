package com.pro.sync.employee.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.employee.vo.EmployeeVo;

public interface EmployeeService {

	public List<EmployeeVo> getAllEmployee();
	
	public int insertEmployee(EmployeeVo employeeVo);
	
	public EmployeeVo employeeSelectDetail(String emp_id);
	
	public int updateEmployee(Map<String, String> inMap);
	
	public int deleteEmployee(String emp_id);
	
}
