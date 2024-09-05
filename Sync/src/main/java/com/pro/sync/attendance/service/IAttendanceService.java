package com.pro.sync.attendance.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.attendance.vo.AttendanceVo;

public interface IAttendanceService {
	
	public List<String> getEmpId();
	
	public int insertCheckIn(String emp_id);
	
//	public int updateCheckOut(String emp_id);
	public int updateCheckOut(Map<String, Object> map);
	
	public boolean isAlreadyCheckedIn(String emp_id);
	
	public String getCheckInTime(String emp_id);
	public String getCheckOutTime(String emp_id);
	public String getWorkDuration(String emp_id);
	
	public int updateWorkDuration(String emp_id);
	public String selectTotalDuration(String emp_id);
	
	/**
	 * 주간 근무 시간 합산 조회
	 * @param emp_id
	 * @return
	 */
	public String getWeekDuration(String emp_id);
	/**
	 * 월간 근무 시간 합산 조회
	 * @param emp_id
	 * @return
	 */
	public String getMonthDuration(String emp_id);
	/**
	 * 일주일간의 근무시간 내역
	 * @param emp_id
	 * @return
	 */
	public List<AttendanceVo> getWeekHistory(String emp_id);

}
