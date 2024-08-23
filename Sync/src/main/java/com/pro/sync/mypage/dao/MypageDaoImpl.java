package com.pro.sync.mypage.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.pro.sync.off.vo.OffVo;

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
	public int updateMyInfo(Map<String, Object> map) {
		log.info("MypageDaoImpl 개인정보 수정 : "+ map);
		return session.update(NS+"updateEmpInfo", map);
	}
}
