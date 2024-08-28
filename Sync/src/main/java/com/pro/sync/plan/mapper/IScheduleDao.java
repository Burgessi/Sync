package com.pro.sync.plan.mapper;

import java.util.List;
import java.util.Map;

import com.pro.sync.plan.vo.ScheduleVo;

public interface IScheduleDao {
	
	//일정 리스트
	public List<ScheduleVo> selectScd();

	//일정 등록
	public int addScd(ScheduleVo vo);
	
	//일정 상세보기
	public ScheduleVo detailScd(int scd_no);
	
	//일정 삭제 
	public int delScd(int scd_no);
	
	//일정 수정
	public boolean updateScd(Map<String, Object> map);
	
	
}
