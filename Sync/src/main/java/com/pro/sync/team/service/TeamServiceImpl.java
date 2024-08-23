package com.pro.sync.team.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pro.sync.team.dao.TeamDao;
import com.pro.sync.team.vo.TeamVo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TeamServiceImpl implements TeamService {

	private final TeamDao dao;
	
	@Override
	public List<TeamVo> getAllTeam() {
		return dao.getAllTeam();
	}

	@Override
	public TeamVo getOneTeam(String code) {
		return dao.getOneTeam(code);
	}

}
