package com.pro.sync.employee.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pro.sync.common.aop.UpdateSession;
import com.pro.sync.employee.dao.EmployeeDao;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements EmployeeService {

	private final EmployeeDao dao;
	
	@Override
	@UpdateSession
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
  	public int updateEmployee(Map<String, String> map) {
  		return dao.updateEmployee(map);
  	}
  	
  	@Override
  	public int deleteEmployee(String emp_id) {
  		
  		//현재 날짜를 퇴사일로
  		//String empLeavingDate=LocalDate.now().toString();
  		// 현재 날짜를 "YYYY-MM-DD" 형식으로 변환
  		
  		return dao.deleteEmployee(emp_id);
  	}
}

