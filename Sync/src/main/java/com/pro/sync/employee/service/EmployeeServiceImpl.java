package com.pro.sync.employee.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pro.sync.employee.dao.EmployeeDao;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService {

	private final EmployeeDao dao;
	
	@Override
	public List<EmployeeVo> getAllEmployee() {
		return dao.getAllEmployee();
	}
  
  	@Override
	public int insertEmployee(EmployeeVo employeeVo) {	
		return dao.insertEmployee(employeeVo); 
	}
  	
  	@Override
  	public EmployeeVo employeeSelectDetail(String emp_id) {
  		return dao.employeeSelectDetail(emp_id);
  	}
  	
 	@Override
  	public int updateEmployee(EmployeeVo employeeVo) {
  		return dao.updateEmployee(employeeVo);
  	}
  	
  	@Override
  	public int deleteEmployee(String emp_id) {
  		return dao.deleteEmployee(emp_id);
  	}
}

