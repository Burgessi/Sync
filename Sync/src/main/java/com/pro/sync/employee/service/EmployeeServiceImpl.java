package com.pro.sync.employee.service;

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
	@UpdateSession
	public List<EmployeeVo> allEmployee(int page, int countRow) {
		int startIndex = (page - 1) * countRow + 1;
		
		return dao.allEmployee(startIndex, countRow);
	}
	
	@Override
	public int totalCount() {
		return dao.totalCount();
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
  		return dao.deleteEmployee(emp_id);
  	}
  	
  	public List<EmployeeVo> searchEmployee(Map<String, Object> map){
  		return dao.searchEmployee(map);
  	}

	@Override
	public int insertOffHistory(Map<String, Object> map) {
		return dao.insertOffHistory(map);
	}
  	
}

