package com.pro.sync.reservations.service;



import java.util.List;

import com.pro.sync.reservations.vo.ReservationsVo;

public interface IReservationService {
	
	//시설예약
	public boolean insertRev(ReservationsVo vo);
	
	//중복검사 
	public int selectOverlap(ReservationsVo vo);
	
	//내가 예약한 목록
	public List<ReservationsVo> selectMyRev(String emp_id);
	
	//다른 팀 예약 목록
	public List<ReservationsVo> currentUseRev();
	
	//예약 삭제
	public int deleteRev(List<String> rev_id);
	

}
