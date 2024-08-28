package com.pro.sync.mypage.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.mypage.vo.AccountVo;
import com.pro.sync.mypage.vo.OffVo;

public interface IMypageService {

	
	public int getUsedOff(String emp_id);
	
	public List<OffVo> getOffHistory(String emp_id);
	
	public EmployeeVo getInfo(String emp_id);
	public AccountVo getAccountInfo(String emp_id);
	
	public int updateEmailAddr(Map<String, Object> map);
	public int updateAccount(AccountVo vo);
	public int insertAccount(AccountVo vo);
	public int updatePassword(Map<String, Object> map);
	public int updateProfilepic(Map<String, Object> map);
}
