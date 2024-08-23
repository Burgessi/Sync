package com.pro.sync.employee.service;

import java.util.List;

import com.pro.sync.employee.vo.EmployeeVo;

public interface IEmployeeService {
	public List<EmployeeVo> employeeSelectAll();
	public int insertEmployee(EmployeeVo employeeVo);
	

}
