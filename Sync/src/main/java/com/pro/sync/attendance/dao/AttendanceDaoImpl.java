package com.pro.sync.attendance.dao;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;


@Repository
public class AttendanceDaoImpl implements IAttendanceDao {

	@Autowired
	SqlSessionTemplate session;
	
	private String NS = "com.pro.sync.attendance.dao.AttendanceDaoImpl.";
	

	@Override
	public List<String> getEmpId() {
		return session.selectList(NS+"getEmpId");
	}
	
	@Override
	public boolean isAlreadyCheckedIn(String emp_id) {
		 try {
		        Integer count = session.selectOne(NS + "isAlreadyCheckedIn", emp_id);
		        return count != null && count > 0;
		    } catch (Exception e) {
		        e.printStackTrace(); // 로그에 예외를 기록합니다.
		        throw new RuntimeException("Error checking attendance", e); // 적절한 예외를 던집니다.
		    }
	}

	@Override
	public int insertCheckIn(String emp_id) {
		return session.insert(NS+"insertCheckIn", emp_id);
	}
	
//	@Override
//	public int updateCheckOut(String emp_id) {
//		return session.update(NS+"updateCheckOut", emp_id);
//	}
	@Override
	public int updateCheckOut(Map<String, Object> map) {
		return session.update(NS+"updateCheckOut", map);
	}
	
	@Override
	public String getCheckInTime(String emp_id) {
		return session.selectOne(NS+"getCheckInTime", emp_id);
	}
	@Override
	public String getCheckOutTime(String emp_id) {
		return session.selectOne(NS+"getCheckOutTime", emp_id);
	}

}
