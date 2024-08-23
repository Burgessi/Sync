package com.pro.sync.employee.service;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Service;

import com.pro.sync.employee.dao.IEmployeeDao;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class EmployeeServiceImpl implements IEmployeeService {
	
	private final IEmployeeDao dao;

	@Override
	public List<EmployeeVo> employeeSelectAll() {
		log.info("EmployeeServiceImpl {}","getAllEmployees");
		
		return dao.employeeSelectAll();
	}
	
	@Override
	public int insertEmployee(EmployeeVo employeeVo) {
		log.info("EmployeeServiceImpl {}", "insertEmployee");
		
		return dao.insertEmployee(employeeVo); 
	}
	

}
