package com.pro.sync.facilities.mapper;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.facilities.vo.FacilitiesVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor

public class FacilitiesDaoImpl implements IFacilitiesDao {
	
	private final SqlSessionTemplate session;
	private final String NS = "com.pro.sync.facilities.mapper.FacilitiesDaoImpl.";
	
	@Override
	public int insertFcl(Map<String, Object> map) {
		return session.insert(NS + "insertFcl", map);
	}

	@Override
	public List<FacilitiesVo> selectFcl() {
		return session.selectList(NS + "selectFcl");
	}

	@Override
	public FacilitiesVo detailFcl(String fcl_id) {
		return session.selectOne(NS + "detailFcl", fcl_id);
	}

	@Override
	public int deleteFcl(String fcl_id) {
		return session.delete(NS + "deleteFcl", fcl_id);
	}

	@Override
	public int updateFcl(String fcl_id) {
		return session.update(NS + "updateFcl", fcl_id);
	}

	@Override
	public int disposableFcl(String fcl_id) {
		return session.update(NS + "disposableFcl", fcl_id);
	}

}
