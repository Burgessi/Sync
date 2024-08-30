package com.pro.sync.approval.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.approval.vo.ApprovalLineVo;
import com.pro.sync.approval.vo.ApprovalVo;

public interface IApprovalService {

	public int requestApproval(ApprovalVo vo, Map<String, String> inMap, List<String> referrer);
	
	public int tempSaveApproval(ApprovalVo vo);
	
	public List<ApprovalVo> getApprovalsList(String employeeId);
	
	public ApprovalVo getApprovalDetail(Map<String, String> info);
	
	public int updateApprovalFlag(Map<String, String> flag);
	
	public int modifyApproval(Map<String, String> info);

	public List<ApprovalVo> getAllReceivedApproval(String employeeId);

	public int confirmApprovalLine(Map<String, String> sign, Map<String, String> line);
	
	public int updateLineStatus(Map<String, String> lineInfo);
	
	public List<ApprovalVo> getTempSaveList(String employeeId);
	
	public ApprovalVo getTempApprovalDetail(Map<String, String> info);
	
	public int requestTempApproval(Map<String, String> inMap, List<String> referrer);
	
}
