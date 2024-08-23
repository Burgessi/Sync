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

}
