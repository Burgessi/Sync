package com.pro.sync.employee.dao;


import java.util.List;

import com.pro.sync.employee.vo.EmployeeVo;

public interface IEmployeeDao {
	public List<EmployeeVo> employeeSelectAll();
	public int insertEmployee(EmployeeVo employeeVo);
}
