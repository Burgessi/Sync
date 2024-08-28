package com.pro.sync.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.mypage.dao.IMypageDao;
import com.pro.sync.mypage.vo.AccountVo;
import com.pro.sync.mypage.vo.OffVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class MypageServiceImpl implements IMypageService {

	@Autowired
	IMypageDao dao;
	
	
	
	@Override
	public int getUsedOff(String emp_id) {
		log.info("사용 연차 조회 서비스 : {}",emp_id);
		return dao.getUsedOff(emp_id);
	}

	@Override
	public List<OffVo> getOffHistory(String emp_id) {
		log.info("사용 연차 이력 서비스 : {}",emp_id);
		return dao.getOffHistory(emp_id);
	}
	
	@Override
	public EmployeeVo getInfo(String emp_id) {
		// TODO Auto-generated method stub
		return dao.getInfo(emp_id);
	}
	
	@Override
	public AccountVo getAccountInfo(String emp_id) {
		// TODO Auto-generated method stub
		return dao.getAccountInfo(emp_id);
	}
	
	@Override
	public int updateEmailAddr(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.updateEmailAddr(map);
	}

	@Override
	public int updateAccount(AccountVo vo) {
		// TODO Auto-generated method stub
		return dao.updateAccount(vo);
	}
	
	@Override
	public int insertAccount(AccountVo vo) {
		// TODO Auto-generated method stub
		return dao.insertAccount(vo);
	}
	
	@Override
	public int updatePassword(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.updatePassword(map);
	}
	
	@Override
	public int updateProfilepic(Map<String, Object> map) {
		// TODO Auto-generated method stub
		return dao.updateProfilepic(map);
	}
}
