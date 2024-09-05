package com.pro.sync.employee.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.employee.vo.EmployeeVo;

public interface EmployeeService {

	public List<EmployeeVo> getAllEmployee();
	
	public List<EmployeeVo> allEmployee(int startIndex, int pageSize);
	
	public int insertEmployee(EmployeeVo employeeVo);
	
	public EmployeeVo employeeSelectDetail(String emp_id);

	public int updateEmployee(Map<String, String> map);
	
	public int deleteEmployee(String emp_id);
	
	public int totalCount();
	
	//검색
	public List<EmployeeVo> searchEmployee(Map<String, Object>map);
	
}
