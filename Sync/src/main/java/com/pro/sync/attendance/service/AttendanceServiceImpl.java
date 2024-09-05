package com.pro.sync.attendance.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.pro.sync.attendance.dao.IAttendanceDao;
import com.pro.sync.attendance.vo.AttendanceVo;

@Service
public class AttendanceServiceImpl implements IAttendanceService {

	@Autowired
	IAttendanceDao dao;
	

	@Override
	public List<String> getEmpId() {
		return dao.getEmpId();
	}

	@Override
	public int insertCheckIn(String emp_id) {
		return dao.insertCheckIn(emp_id);
	}
	
//	@Override
//	public int updateCheckOut(String emp_id) {
//		return dao.updateCheckOut(emp_id);
//	}
	
	@Override
	public int updateCheckOut(Map<String, Object> map) {
		return dao.updateCheckOut(map);
	}
	
	@Override
	public boolean isAlreadyCheckedIn(String emp_id) {
		return dao.isAlreadyCheckedIn(emp_id);
	}
	
	@Override
	public String getCheckInTime(String emp_id) {
		return dao.getCheckInTime(emp_id);
	}
	
	@Override
	public String getCheckOutTime(String emp_id) {
		return dao.getCheckOutTime(emp_id);
	}
	@Override
	public String getWorkDuration(String emp_id) {
		return dao.getWorkDuration(emp_id);
	}

	@Override
	public int updateWorkDuration(String emp_id) {
		return dao.updateWorkDuration(emp_id);
	}

	@Override
	public String selectTotalDuration(String emp_id) {
		return dao.selectTotalDuration(emp_id);
	}

	@Override
	public String getWeekDuration(String emp_id) {
		return dao.getWeekDuration(emp_id);
	}

	@Override
	public String getMonthDuration(String emp_id) {
		return dao.getMonthDuration(emp_id);
	}

	@Override
	public List<AttendanceVo> getWeekHistory(String emp_id) {
		return dao.getWeekHistory(emp_id);
	}
}
