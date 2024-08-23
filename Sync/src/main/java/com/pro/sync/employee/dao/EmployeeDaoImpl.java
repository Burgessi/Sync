package com.pro.sync.employee.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.sync.employee.vo.EmployeeVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class EmployeeDaoImpl implements IEmployeeDao {
	
	@Autowired
	private SqlSessionTemplate session;

	private final String NS = "com.pro.sync.employee.dao.EmployeeDaoImpl.";

	@Override
	public List<EmployeeVo> employeeSelectAll() {
		return session.selectList(NS+"employeeSelectAll");
	}
	
	@Override
	public int insertEmployee(EmployeeVo employeeVo) {
		log.info("새로운 사원 등록");

		return session.insert(NS + "insertEmployee", employeeVo);
	}
	
	

}
