package com.pro.sync.approval.dao;

import java.util.List;
import java.util.Map;

import com.pro.sync.approval.vo.ApprovalLineVo;
import com.pro.sync.approval.vo.ApprovalVo;

public interface IApprovalDao {

	public int requestApproval(ApprovalVo vo);
	
	public int insertApprovalLines(List<ApprovalLineVo> approvalLine);
	
	public int tempSaveApproval(ApprovalVo vo);
	
	public List<ApprovalVo> getApprovalsList(String employeeId);
	
	public ApprovalVo getApprovalDetail(Map<String, String> info);
	
	public int updateApprovalFlag(Map<String, String> flag);
	
	public int modifyApproval(Map<String, String> info);
	
	public List<ApprovalVo> getAllReceivedApproval(String employeeId);
	
}
