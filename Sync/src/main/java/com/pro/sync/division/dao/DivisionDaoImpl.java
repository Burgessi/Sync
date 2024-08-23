package com.pro.sync.division.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.division.vo.DivisionVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DivisionDaoImpl implements DivisionDao {

	private final String NS = "com.pro.sync.division.dao.DivisionDaoImpl.";
	
	private final SqlSessionTemplate sessionTemplate;
	
	
	@Override
	public List<DivisionVo> getAllDivision() {
		return sessionTemplate.selectList(NS+"getAllDivision");
	}

}
