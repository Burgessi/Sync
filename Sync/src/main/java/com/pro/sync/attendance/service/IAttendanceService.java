package com.pro.sync.attendance.service;

import java.util.List;
import java.util.Map;

public interface IAttendanceService {
	
	public List<String> getEmpId();
	
	public int insertCheckIn(String emp_id);
	
//	public int updateCheckOut(String emp_id);
	public int updateCheckOut(Map<String, Object> map);
	
	public boolean isAlreadyCheckedIn(String emp_id);
	
	public String getCheckInTime(String emp_id);
	public String getCheckOutTime(String emp_id);
}
