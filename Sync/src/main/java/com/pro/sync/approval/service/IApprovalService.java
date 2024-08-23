package com.pro.sync.approval.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.approval.vo.ApprovalVo;

public interface IApprovalService {

	public int requestApproval(ApprovalVo vo, Map<String, String> inMap, List<String> referrer);
	
	public int tempSaveApproval(ApprovalVo vo);
	
}
