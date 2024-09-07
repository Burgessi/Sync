package com.pro.sync.approval.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.Base64;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.ServletContext;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.util.Base64Utils;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.pro.sync.approval.service.IApprovalService;
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
	private final IApprovalService approvalService;
	
	
	 @Autowired
	 private ServletContext servletContext;
	
	
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
			
			JSONObject stateJson = new JSONObject();
		    stateJson.put("disabled", true);  // 노드 완전히 비활성화
		    stateJson.put("selected", false); // 선택 상태 초기화
		    divisonJson.put("state", stateJson);
			    
			 // 체크박스를 숨기기 위한 클래스 추가
		    JSONObject liAttrJson = new JSONObject();
		    liAttrJson.put("class", "no-checkbox");
		    divisonJson.put("li_attr", liAttrJson);   
			    
			
			treeList.add(divisonJson);
		}
		
		for(int i=0; i<teamList.size(); i++) {
			JSONObject teamJson = new JSONObject();
			teamJson.put("id", teamList.get(i).getTeam_code());
			teamJson.put("text", teamList.get(i).getTeam_name());
			teamJson.put("parent", teamList.get(i).getUpstairs_division_code());
			teamJson.put("icon", "../resources/img/approval_img/team.png");
			
			// 노드 비활성화 및 커스텀 클래스 추가
		    JSONObject stateJson = new JSONObject();
		    stateJson.put("disabled", true);
		    stateJson.put("selected", false);
		    teamJson.put("state", stateJson);

		    // 체크박스를 숨기기 위한 클래스 추가
		    JSONObject liAttrJson = new JSONObject();
		    liAttrJson.put("class", "no-checkbox");
		    teamJson.put("li_attr", liAttrJson);
			
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
				employeeJson.put("profile", employeeList.get(i).getEmp_profile_pic());
				treeList.add(employeeJson);
			}
		}
		return treeList;
	}
	
	
	//결재승인
	@PostMapping("/completeApproval.do")
	public String saveSignature(@RequestBody Map<String, String> request) {
		System.out.println("[받은 requeset:] " + request);
		String approval_id = request.get("approvalId");
		String recipient_id = request.get("recipientId");
		String status = request.get("approvalStatus");
		
		String fileName = "";
		String image = request.remove("image");
		
		if(!status.equals("0")) {
			Map<String, Object> statusMap = new HashMap<String, Object>();
			statusMap.put("approval_id", approval_id);
			statusMap.put("approval_status", status);
			approvalService.updateApprovalStatus(statusMap);
		}
		
		
		 try {
			 
			 	if(!image.equals("") && image != null) {
			 
		            // Base64로 인코딩된 이미지 데이터에서 실제 바이너리 데이터로 변환
		            String base64Image = image.split(",")[1];
		            byte[] decodedBytes = Base64Utils.decodeFromString(base64Image);
		            System.out.println("이미지 디코딩 성공");
	
		            // webapp/resources/img의 실제 경로 얻기
	//	            String path = "C:\\Users\\pkr\\git\\Sync\\Sync\\src\\main\\webapp\\resources\\img\\signature\\";
		            String realPathToImg = servletContext.getRealPath("/resources/img/signature/");
	//	            System.out.println("실제 경로: " + realPathToImg);
		            
	//	            // 디렉토리가 없으면 생성
		            File directory = new File(realPathToImg);
		            if (!directory.exists()) {
		                directory.mkdirs();
		            }
	
		            // 파일명을 UUID로 생성하여 중복 방지
		            fileName = recipient_id + ".png";
		            System.out.println("파일명: " + fileName);
	
		            // 파일을 지정된 경로에 저장
		            File file = new File(directory, fileName);
	//	            File file = new File("http://localhost:8080/Sync/src/main/webapp/resources/img/signature/", fileName);
		            try (FileOutputStream fos = new FileOutputStream(file)) {
		                fos.write(decodedBytes);
		                System.out.println("파일 저장 성공: " + file.getAbsolutePath());
		            }
		            
		            System.out.println("저장완료");
			 	}
			 	
	            //사원 정보 업데이트 -> 서명입력을 위한 정보
	            Map<String, String> sign = new HashMap<String, String>();
	            sign.put("emp_id", recipient_id);
	            sign.put("emp_signature", fileName);
	            
	            //결재라인 업데이트 -> 결재라인에 대한 정보
	            Map<String, String> line = new HashMap<String, String>();
	            line.put("approval_id", approval_id);
	            line.put("status", "1");
	            line.put("recipient_id", recipient_id);
	            
	            approvalService.confirmApprovalLine(sign, line);
	            
	            return "true";

	        } catch (IOException e) {
	            e.printStackTrace();
	            return "false";
	        }
		
	}
	
	//결재 반려
	@PostMapping("/rejectionApproval.do")
	public ResponseEntity<String> rejectionApproval(@RequestParam Map<String, String> rejection) {
		String status = "2";
		rejection.put("status", status);
		rejection.put("status", status);
		System.out.println("반려확인 : " + rejection);
		
		String approval_id =  rejection.get("approval_id");
		int approval_status = 2;
		Map<String, Object> approvalStatus = new HashMap<String, Object>();
		approvalStatus.put("approval_id", approval_id);
		approvalStatus.put("approval_status", approval_status);
		approvalService.updateApprovalStatus(approvalStatus);
		
		
		//반려시 --> 결재라인 status를 변경, 반려사유 입력.
		approvalService.updateLineStatus(rejection);
		
		return ResponseEntity.ok("true");
	}
	
	
}
