package com.pro.sync.mypage.dao;

import java.util.List;
import java.util.Map;

import com.pro.sync.off.vo.OffVo;

public interface IMypageDao {

	/**
	 * 사용연차 조회
	 * @param emp_id
	 * @return 
	 */
	public int getUsedOff(String emp_id);
	
	/**
	 * 연차 이력 조회
	 * @param emp_id
	 * @return
	 */
	public List<OffVo> getOffHistory(String emp_id);
	/**
	 * 개인정보 수정
	 * @param map emp_email, emp_phone, addr1, addr2, emp_id
	 * @return
	 */
	public int updateMyInfo(Map<String, Object> map);
}
