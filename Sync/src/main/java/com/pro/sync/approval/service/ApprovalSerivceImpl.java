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

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ApprovalSerivceImpl implements IApprovalService {

	private final IApprovalDao dao;
	
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
		String title = inMap.remove("title"); //db에서 document_type
		approval.setDocument_type(title);
		
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


}
