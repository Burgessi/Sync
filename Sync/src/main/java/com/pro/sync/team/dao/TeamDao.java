package com.pro.sync.team.dao;

import java.util.List;

import com.pro.sync.team.vo.TeamVo;

public interface TeamDao {

	public List<TeamVo> getAllTeam();
	
	public TeamVo getOneTeam(String code);
	
}
