package com.pro.sync.reservations.service;



import java.util.List;

import org.springframework.stereotype.Service;

import com.pro.sync.reservations.mapper.IReservationDao;
import com.pro.sync.reservations.vo.ReservationsVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
@Slf4j
@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements IReservationService {
	
	private final IReservationDao dao;

	@Override
	public boolean insertRev(ReservationsVo vo) {
		log.info("시설등록");
		return dao.insertRev(vo);
	}

	@Override
	public int selectOverlap(ReservationsVo vo) {
		log.info("중복검사");
		return dao.selectOverlap(vo);
	}

	@Override
	public List<ReservationsVo> selectMyRev(String emp_id) {
		log.info("내가 예약한 목록");
		return dao.selectMyRev(emp_id);
	}

	@Override
	public List<ReservationsVo> currentUseRev() {
		log.info("다른 팀 목록");
		return dao.currentUseRev();
	}

	@Override
	public int deleteRev(List<String> rev_id) {
		log.info("예약 삭제");
		return dao.deleteRev(rev_id);
	}


}
