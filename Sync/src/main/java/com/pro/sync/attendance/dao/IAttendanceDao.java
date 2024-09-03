package com.pro.sync.attendance.dao;

import java.util.List;
import java.util.Map;


public interface IAttendanceDao {

	
	/**
	 * 사번조회
	 * @return
	 */
	public List<String> getEmpId();
	
	/**
	 * 출근기록 있는지 체크
	 * @param emp_id
	 * @return
	 */
	public boolean isAlreadyCheckedIn(String emp_id);
	
	/**
	 * 출근시각 기록
	 * @param emp_id
	 * @return
	 */
	public int insertCheckIn(String emp_id);
	/**
	 * 퇴근시각 기록
	 * @param emp_id
	 * @return
	 */
//	public int updateCheckOut(String emp_id);
	public int updateCheckOut(Map<String, Object> map);
	
	/**
	 * 출근시각 조회
	 * @param empId
	 * @return
	 */
	public String getCheckInTime(String emp_id);
	public String getCheckOutTime(String emp_id);
	
}
