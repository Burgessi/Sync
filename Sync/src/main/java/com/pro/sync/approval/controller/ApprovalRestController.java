package com.pro.sync.approval.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pro.sync.division.service.DivisionService;
import com.pro.sync.division.vo.DivisionVo;
import com.pro.sync.employee.service.EmployeeService;
import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.team.service.TeamService;
import com.pro.sync.team.vo.TeamVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RestController
@RequiredArgsConstructor
@RequestMapping(value = "/approval")
@Slf4j
public class ApprovalRestController {

	private final EmployeeService employeeService;
	private final TeamService teamService;
	private final DivisionService divisionService;
	
	
	//결재선 jstreeAjax
	@PostMapping("/approvalJstree.do")
	public List<Map<String, Object>> jstree(){
		
		//json
		JSONArray treeList = new JSONArray();
		
		List<DivisionVo> divisionList = divisionService.getAllDivision();
		List<TeamVo> teamList = teamService.getAllTeam();
		List<EmployeeVo> employeeList =  employeeService.getAllEmployee();
		 
		
		for(int i=0; i<divisionList.size(); i++) {
			JSONObject divisonJson = new JSONObject();
			divisonJson.put("id", divisionList.get(i).getDivision_code());
			divisonJson.put("text", divisionList.get(i).getDivision_name());
			divisonJson.put("parent", "#" );
			divisonJson.put("icon", "../resources/img/approval_img/division.png");
			treeList.add(divisonJson);
		}
		
		for(int i=0; i<teamList.size(); i++) {
			JSONObject teamJson = new JSONObject();
			teamJson.put("id", teamList.get(i).getTeam_code());
			teamJson.put("text", teamList.get(i).getTeam_name());
			teamJson.put("parent", teamList.get(i).getUpstairs_division_code());
			teamJson.put("icon", "../resources/img/approval_img/team.png");
			treeList.add(teamJson);
		}
		
		if(employeeList.size() >0) {
			for(int i=0; i<employeeList.size(); i++) {
				JSONObject employeeJson = new JSONObject();
				employeeJson.put("id",employeeList.get(i).getEmp_id());
				employeeJson.put("text", employeeList.get(i).getEmp_name());
				employeeJson.put("parent", employeeList.get(i).getTeam_code());
				employeeJson.put("icon", "../resources/img/approval_img/employee.png");
				employeeJson.put("team", teamService.getOneTeam(employeeList.get(i).getTeam_code()).getTeam_name());
				employeeJson.put("rank", employeeList.get(i).getRank_name());
				treeList.add(employeeJson);
			}
		}
		return treeList;
	}
	
//	@PostMapping("/saveSignature.do")
//	public String saveSignature(@RequestBody String url) {
//		
//	
//		
//	}
	
}
