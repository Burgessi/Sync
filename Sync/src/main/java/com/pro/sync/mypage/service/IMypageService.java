package com.pro.sync.mypage.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.employee.vo.OffVo;

public interface IMypageService {

	public int getUsedOff(String emp_id);
	
	public List<OffVo> getOffHistory(String emp_id);
	
	public int updateMyInfo(Map<String, Object> map);

}
