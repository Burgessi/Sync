package com.pro.sync.facilities.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pro.sync.facilities.mapper.IFacilitiesDao;
import com.pro.sync.facilities.vo.FacilitiesVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class FacilitiesServiceImpl implements IFacilitiesService {
	
	private final IFacilitiesDao dao;

	@Override
	public int insertFcl(Map<String, Object> map) {
		log.info("회의실 등록");
		return dao.insertFcl(map);
	}

	@Override
	public List<FacilitiesVo> selectFcl() {
		log.info("회의실 리스트 이동");
		return dao.selectFcl();
	}

	@Override
	public FacilitiesVo detailFcl(String fcl_id) {
		log.info("회의실 상세보기");
		return dao.detailFcl(fcl_id);
	}

	@Override
	public int deleteFcl(String fcl_id) {
		log.info("회의실 삭제");
		return dao.deleteFcl(fcl_id);
	}

	@Override
	public int updateFcl(String fcl_id) {
		log.info("회의실 사용불가");
		return dao.updateFcl(fcl_id);
	}

	@Override
	public int disposableFcl(String fcl_id) {
		log.info("회의실 사용가능");
		return dao.disposableFcl(fcl_id);
	}
	
	

}
