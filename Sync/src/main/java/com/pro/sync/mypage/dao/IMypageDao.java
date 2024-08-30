package com.pro.sync.mypage.dao;

import java.util.List;
import java.util.Map;


import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.mypage.vo.AccountVo;
import com.pro.sync.mypage.vo.OffVo;


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
	 * 회원 정보 조회
	 * @param emp_id
	 * @return EmployeeVo 본부/팀/직급 포함
	 */
	public EmployeeVo getInfo(String emp_id);
	
	/**
	 * 계좌 정보 조회
	 * @param emp_id
	 * @return AccountVo
	 */
	public AccountVo getAccountInfo(String emp_id);
	
	/**
	 * 개인정보 수정 - 이메일/주소
	 * @param map emp_email,emp_phone,addr1,addr2,emp_id
	 * @return
	 */
	public int updateEmailAddr(Map<String, Object> map);
	
	/**
	 * 개인정보 수정 - 급여 계좌
	 * @param map account_num,account_holder,bank_name,relation_to_emp,emp_id
	 * @return
	 */
	public int updateAccount(AccountVo vo);
	
	/**
	 * 개인정보 수정 - 급여 계좌 없을 경우 insert
	 * @param vo
	 * @return
	 */
	public int insertAccount(AccountVo vo);
	
	/**
	 * 개인정보 수정 - 비밀번호
	 * @param map emp_password, emp_id
	 * @return
	 */
	public int updatePassword(Map<String, Object> map);
	
	/**
	 * 개인정보 수정 - 프로필사진
	 * @param map emp_profile_pic, emp_id
	 * @return
	 */
	public int updateProfilepic(Map<String, Object> map);
	
	/**
	 * 회원 존재 여부 체크
	 * @param map emp_id, emp_email
	 * @return 1=존재 0=없음
	 */
	public int checkUser(Map<String, Object> map);
	
	
	
	
	
}
