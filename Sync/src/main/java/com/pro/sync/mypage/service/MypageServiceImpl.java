package com.pro.sync.mypage.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.sync.mypage.dao.IMypageDao;
import com.pro.sync.off.vo.OffVo;

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
	public int updateMyInfo(Map<String, Object> map) {
		log.info("개인정보 수정 서비스 : {}",map);
		return dao.updateMyInfo(map);
	}
}
