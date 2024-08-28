package com.pro.sync.plan.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pro.sync.plan.mapper.IScheduleDao;
import com.pro.sync.plan.vo.ScheduleVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class ScheduleServiceImpl implements IScheduleService {

	private final IScheduleDao dao;

	@Override
	public int addScd(ScheduleVo vo) {
		log.info("등록된 값 : {}", "addScd");
		return dao.addScd(vo);
	}

	@Override
	public List<ScheduleVo> selectScd() {
		log.info("전체 스케줄 보기");
		return dao.selectScd();
	}
	
	@Override
	public ScheduleVo detailScd(int scd_no) {
		log.info("일정 상세보기");
		return dao.detailScd(scd_no);
	}

	@Override
	public int delScd(int scd_no) {
		log.info("일정 삭제");
		return dao.delScd(scd_no);
	}

	@Override
	public boolean updateScd(Map<String, Object> map) {
		log.info("일정 수정");
		return dao.updateScd(map);
	}
	
	
}
