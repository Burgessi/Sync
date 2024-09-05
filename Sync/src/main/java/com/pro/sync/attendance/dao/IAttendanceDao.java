package com.pro.sync.attendance.dao;

import java.util.List;
import java.util.Map;

import com.pro.sync.attendance.vo.AttendanceVo;


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
	/**
	 * 퇴근시각 조회
	 * @param emp_id
	 * @return
	 */
	public String getCheckOutTime(String emp_id);
	/**
	 * 근무시간 조회
	 * @param emp_id
	 * @return
	 */
	public String getWorkDuration(String emp_id);
	/**
	 * 근무시간 기록
	 * @param emp_id
	 * @return
	 */
	public int updateWorkDuration(String emp_id);
	/**
	 * 총 근무시간 합산
	 * @param emp_id
	 * @return
	 */
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
