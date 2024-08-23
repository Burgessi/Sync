package com.pro.sync.approval.vo;


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
	private String approval_content;
	private String temp_save_flag;
	private String delete_flag;
	private String requester_id;
	private String request_date;
	private String modified_date;

}
