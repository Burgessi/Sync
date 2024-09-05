
package com.pro.sync.employee.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class EmployeeDaoImpl implements EmployeeDao{

	private final String NS = "com.pro.sync.employee.dao.EmployeeDaoImpl.";
	
	private final SqlSessionTemplate sessionTemplate;
	
	@Override
	public List<EmployeeVo> getAllEmployee() {
		return sessionTemplate.selectList(NS+"getAllEmployee");
	}
	
	@Override
	public List<EmployeeVo> allEmployee(int startIndex, int pageSize) {
		int endIndex = startIndex + pageSize - 1;
		
		return sessionTemplate.selectList(NS+"allEmployee", Map.of("startIndex", startIndex, "endIndex", endIndex));
	}
	
	@Override
	public int totalCount() {
		return sessionTemplate.selectOne(NS + "totalCount");
	}
  
  	@Override
	public int insertEmployee(EmployeeVo employeeVo) {
		return sessionTemplate.insert(NS + "insertEmployee", employeeVo);
	}
  	
	@Override
  	public EmployeeVo employeeSelectDetail(String emp_id) {
  		return sessionTemplate.selectOne(NS+"employeeSelectDetail", emp_id);
  	}
	
	@Override
	public int updateEmployee(Map<String, String> map) {
		return sessionTemplate.update(NS+"updateEmployee",map);
	}
	
	@Override
	public int deleteEmployee(String emp_id) {
		return sessionTemplate.delete(NS+"deleteEmployee",emp_id);
	}
	
	
	@Override
	public List<EmployeeVo> searchEmployee(Map<String, Object> map){
		return sessionTemplate.selectList(NS+"searchEmployee", map);
	}

	
}

