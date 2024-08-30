package com.pro.sync.approval.service;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.google.gson.Gson;
import com.pro.sync.approval.dao.IApprovalDao;
import com.pro.sync.approval.vo.ApprovalLineVo;
import com.pro.sync.approval.vo.ApprovalVo;
import com.pro.sync.employee.dao.EmployeeDao;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalSerivceImpl implements IApprovalService {

	private final IApprovalDao dao;
	private final EmployeeDao employeeDao;
	
	@Override
	@Transactional
	public int requestApproval(ApprovalVo approval, Map<String, String> inMap, List<String> referrer) {
		
		//결재라인 insert 위한 list
		List<ApprovalLineVo> approvalLine = new ArrayList<ApprovalLineVo>();
		
		//결재자 정보
		ApprovalLineVo approvalLineVo1 = new ApprovalLineVo();
		ApprovalLineVo approvalLineVo2 = new ApprovalLineVo();
		ApprovalLineVo approvalLineVo3 = new ApprovalLineVo();
		
		//결재 양식 
		String documentType = inMap.remove("documentType"); //db에서 document_type
		approval.setDocument_type(documentType);
		
		approval.setApproval_title(inMap.remove("title"));
		
		//결재자 id 추출
		approvalLineVo1.setRecipient_id(inMap.remove("approvalLine1"));
		approvalLineVo2.setRecipient_id(inMap.remove("approvalLine2"));
		approvalLineVo3.setRecipient_id(inMap.remove("approvalLine3")); 
		inMap.remove("referrer"); //참조자 정보 삭제
		
		//결재 content
		approval.setApproval_content(new Gson().toJson(inMap));
		
		//결재DB입력 후 결재ID 받기
		dao.requestApproval(approval);
		String approvalId = approval.getApproval_id();
		
		
		//결재자 vo가 notnull일 경우 데이터 set
		if(approvalLineVo1.getRecipient_id() != null) {
			approvalLineVo1.setApproval_id(approvalId);
			approvalLineVo1.setRecipient_type("A");
			approvalLineVo1.setStep(1);
			approvalLine.add(approvalLineVo1);
		}
		
		if(approvalLineVo2.getRecipient_id() != null) {
			approvalLineVo2.setApproval_id(approvalId);
			approvalLineVo2.setRecipient_type("A");
			approvalLineVo2.setStep(2);
			approvalLine.add(approvalLineVo2);
		}
		
		if(approvalLineVo3.getRecipient_id() != null) {
			approvalLineVo3.setApproval_id(approvalId);
			approvalLineVo3.setRecipient_type("A");
			approvalLineVo3.setStep(3);
			approvalLine.add(approvalLineVo3);
		}

		//참조자
		if(referrer != null) {
			for (String ref : referrer) {
				ApprovalLineVo referrerVo = new ApprovalLineVo();
				referrerVo.setApproval_id(approvalId);
				referrerVo.setRecipient_type("R");
				referrerVo.setRecipient_id(ref);
				referrerVo.setStep(0);
				approvalLine.add(referrerVo);
			}
		}	
		log.info("결재문서정보 : {}",approval);
		log.info("결재선 정보 : {}",approvalLine);
		return dao.insertApprovalLines(approvalLine);
	}

	@Override
	public int tempSaveApproval(ApprovalVo vo) {
		return dao.tempSaveApproval(vo);
	}

	@Override
	public List<ApprovalVo> getApprovalsList(String employeeId) {
		return dao.getApprovalsList(employeeId);
	}

	@Override
	public ApprovalVo getApprovalDetail(Map<String, String> info){
		return dao.getApprovalDetail(info);
	}

	@Override
	public int updateApprovalFlag(Map<String, String> flag) {
		return dao.updateApprovalFlag(flag);
	}

	@Override
	public int modifyApproval(Map<String, String> info) {
		return dao.modifyApproval(info);
	}

	@Override
	public List<ApprovalVo> getAllReceivedApproval(String employeeId) {
		
		//로그인한 아이디의 문서 다 가져오기.
		
		//1. type이 참조라면 add 
		//2. type이 결재자라면 
		//			-> step이 1이고 status가 0이면 add
		//			-> step이 2이면 
		//			-> step이 3이면 
		
		return dao.getAllReceivedApproval(employeeId);
	}

	@Override
	@Transactional
	public int confirmApprovalLine(Map<String, String> sign, Map<String, String> line) {
		
		System.out.println("[emp_signature]"+sign.get("emp_signature"));
		
		if(sign.get("emp_signature") != null && !sign.get("emp_signature").isEmpty()) {
			//EMPLOYEE의 사진 이름 저장
			employeeDao.updateEmployee(sign);
		}
		
		//LINE 상태 변경
		dao.updateLineStatus(line);
		
		//line 상태 변경된 step가져오기
		String step = dao.getLineStep(line);
		line.put("step", step);
		
		//결재 order 순서변경
		return dao.updateApprovalOrder(line);
	}


	@Override
	public int updateLineStatus(Map<String, String> lineInfo) {
		return dao.updateLineStatus(lineInfo);
	}

	@Override
	public List<ApprovalVo> getTempSaveList(String employeeId) {
		return dao.getTempSaveList(employeeId);
	}

	@Override
	public ApprovalVo getTempApprovalDetail(Map<String, String> info) {
		return dao.getTempApprovalDetail(info);
	}

	@Override
	public int requestTempApproval(Map<String, String> inMap, List<String> referrer) {
		System.out.println("[inMap]"+inMap);	
		System.out.println("[referrer]"+referrer);
		//필요없는 정보 Map에서 지우기
		inMap.remove("temp_save_flag");
		inMap.remove("referrer");
		
		String approvalId = inMap.remove("approvalId");
		
		//임시저장문서 지우기
		dao.tempApprovalDelete(approvalId);
		
		ApprovalVo approval = new ApprovalVo();
		approval.setApproval_id(approvalId);
		approval.setApproval_title(inMap.remove("title"));
		approval.setRequester_id(inMap.remove("requester_id"));
		approval.setDocument_type(inMap.remove("documentType"));
		
		
//		결재라인 insert 위한 list
		List<ApprovalLineVo> approvalLine = new ArrayList<ApprovalLineVo>();
		
		//결재자 정보
		ApprovalLineVo approvalLineVo1 = new ApprovalLineVo();
		ApprovalLineVo approvalLineVo2 = new ApprovalLineVo();
		ApprovalLineVo approvalLineVo3 = new ApprovalLineVo();
		
		
		//결재자 id 추출
		approvalLineVo1.setRecipient_id(inMap.remove("approvalLine1"));
		approvalLineVo2.setRecipient_id(inMap.remove("approvalLine2"));
		approvalLineVo3.setRecipient_id(inMap.remove("approvalLine3")); 
		
		
		//결재 content
		approval.setApproval_content(new Gson().toJson(inMap));
		dao.requestApproval(approval);
		//결재요청후 id 리턴받기
		String newApprovalId = approval.getApproval_id();
		
		
		//결재자 vo가 notnull일 경우 데이터 set
		if(approvalLineVo1.getRecipient_id() != null) {
			approvalLineVo1.setApproval_id(newApprovalId);
			approvalLineVo1.setRecipient_type("A");
			approvalLineVo1.setStep(1);
			approvalLine.add(approvalLineVo1);
		}
		
		if(approvalLineVo2.getRecipient_id() != null) {
			approvalLineVo2.setApproval_id(newApprovalId);
			approvalLineVo2.setRecipient_type("A");
			approvalLineVo2.setStep(2);
			approvalLine.add(approvalLineVo2);
		}
		
		if(approvalLineVo3.getRecipient_id() != null) {
			approvalLineVo3.setApproval_id(newApprovalId);
			approvalLineVo3.setRecipient_type("A");
			approvalLineVo3.setStep(3);
			approvalLine.add(approvalLineVo3);
		}

		//참조자
		if(referrer != null) {
			for (String ref : referrer) {
				ApprovalLineVo referrerVo = new ApprovalLineVo();
				referrerVo.setApproval_id(newApprovalId);
				referrerVo.setRecipient_type("R");
				referrerVo.setRecipient_id(ref);
				referrerVo.setStep(0);
				approvalLine.add(referrerVo);
			}
		}	
		
		log.info("결재문서정보 : {}",approval);
		log.info("결재선 정보 : {}",approvalLine);
		
		//결재라인입력
		return dao.insertApprovalLines(approvalLine);
		
	}
	

}
