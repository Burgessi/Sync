package com.pro.sync.mypage.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.mypage.vo.AccountVo;
import com.pro.sync.mypage.vo.OffVo;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Repository
public class MypageDaoImpl implements IMypageDao {

	@Autowired
	private SqlSessionTemplate session;
	
	private final String NS = "com.pro.sync.mypage.dao.MypageDaoImpl.";
	
	
	
	@Override
	public int getUsedOff(String emp_id) {
		log.info("MypageDaoImpl 사용연차 조회 : "+ emp_id);
		return session.selectOne(NS+"getUsedOff", emp_id);
	}

	@Override
	public List<OffVo> getOffHistory(String emp_id) {
		log.info("MypageDaoImpl 연차이력 조회 : "+ emp_id);
		return session.selectList(NS+"getOffHistory",emp_id);
	}

	@Override
	public EmployeeVo getInfo(String emp_id) {
		log.info("MypageDaoImpl getInfo 조회 : "+ emp_id);
		return session.selectOne(NS+"getInfo", emp_id);
	}
	@Override
	public AccountVo getAccountInfo(String emp_id) {
		return session.selectOne(NS+"getAccountInfo", emp_id);
	}
	
	@Override
	public int updateEmailAddr(Map<String, Object> map) {
		return session.update(NS+"updateEmailAddr", map);
	}
	
	@Override
	public int updateAccount(AccountVo vo) {
		return session.update(NS+"updateAccount", vo);
	}
	
	@Override
	public int insertAccount(AccountVo vo) {
		return session.insert(NS+"insertAccount", vo);
	}
	
	@Override
	public int updatePassword(Map<String, Object> map) {
		return session.update(NS+"updatePassword", map);
	}
	
	@Override
	public int updateProfilepic(Map<String, Object> map) {
		return session.update(NS+"updateProfilepic", map);
	}
	
	@Override
	public int checkUser(Map<String, Object> map) {
		return session.selectOne(NS+"checkUser", map);
	}
	
	
	
 
}
