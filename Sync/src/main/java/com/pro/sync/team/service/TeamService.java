package com.pro.sync.team.service;

import java.util.List;

import com.pro.sync.team.vo.TeamVo;

public interface TeamService {

	public List<TeamVo> getAllTeam();
	
	public TeamVo getOneTeam(String code);
}
