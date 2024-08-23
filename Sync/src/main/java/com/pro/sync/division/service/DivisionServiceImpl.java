package com.pro.sync.division.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pro.sync.division.dao.DivisionDao;
import com.pro.sync.division.vo.DivisionVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DivisionServiceImpl implements DivisionService {

	private final DivisionDao dao;
	
	@Override
	public List<DivisionVo> getAllDivision() {
		return dao.getAllDivision();
	}

}
