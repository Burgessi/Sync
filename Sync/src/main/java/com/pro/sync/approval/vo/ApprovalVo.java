package com.pro.sync.approval.vo;


import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Setter
@Getter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalVo {

	private String approval_id;
	private String document_type;
	private String approval_title;
	private String approval_content;
	private String temp_save_flag;
	private String delete_flag;
	private String requester_id;
	private String requester_name;
	private String request_date;
	private String modified_date;
	private String order;
	private int approval_status;
	private String team_name;
	
	private List<ApprovalLineVo> lineList;

}
