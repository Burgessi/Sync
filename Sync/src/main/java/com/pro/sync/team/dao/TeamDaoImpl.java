package com.pro.sync.team.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.team.vo.TeamVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class TeamDaoImpl implements TeamDao {

	private final String NS = "com.pro.sync.team.dao.TeamDaoImpl.";
	
	private final SqlSessionTemplate sessionTemplate;
	
	@Override
	public List<TeamVo> getAllTeam() {
		return sessionTemplate.selectList(NS+"getAllTeam");
	}

	@Override
	public TeamVo getOneTeam(String code) {
		return sessionTemplate.selectOne(NS+"getOneTeam",code);
	}

}
