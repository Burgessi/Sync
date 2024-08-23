package com.pro.sync.approval.dao;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.pro.sync.approval.vo.ApprovalLineVo;
import com.pro.sync.approval.vo.ApprovalVo;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ApprovalDaoImpl implements IApprovalDao{

	private final String NS = "com.pro.sync.approval.dao.ApprovalDaoImpl.";
	
	private final SqlSessionTemplate sessionTemplate;
	
	@Override
	public int requestApproval(ApprovalVo vo) {
		return sessionTemplate.insert(NS+"requestApproval", vo);
	}

	@Override
	public int insertApprovalLines(List<ApprovalLineVo> approvalLine) {
		return sessionTemplate.insert(NS+"insertApprovalLines", approvalLine);
	}

	@Override
	public int tempSaveApproval(ApprovalVo vo) {
		return sessionTemplate.insert(NS+"tempSaveApproval", vo);
	}


	
}
