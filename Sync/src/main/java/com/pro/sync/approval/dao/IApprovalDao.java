package com.pro.sync.approval.dao;

import java.util.List;

import com.pro.sync.approval.vo.ApprovalLineVo;
import com.pro.sync.approval.vo.ApprovalVo;

public interface IApprovalDao {

	public int requestApproval(ApprovalVo vo);
	
	public int insertApprovalLines(List<ApprovalLineVo> approvalLine);
	
	public int tempSaveApproval(ApprovalVo vo);
	
}
