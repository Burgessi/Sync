package com.pro.sync.facilities.mapper;

import java.util.List;
import java.util.Map;

import com.pro.sync.facilities.vo.FacilitiesVo;

public interface IFacilitiesDao {

	//회의실 등록
	public int insertFcl(Map<String, Object> map);
	
	//회의실 리스트
	public List<FacilitiesVo> selectFcl();
	
	//상세보기
	public FacilitiesVo detailFcl(String fcl_id);
	
	//삭제
	public int deleteFcl(String fcl_id);
	
	//업데이트
	public int updateFcl(String fcl_id);
	
	//업데이트 이용가능
	public int disposableFcl(String fcl_id);
}
