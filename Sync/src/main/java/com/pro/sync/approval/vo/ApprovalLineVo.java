package com.pro.sync.approval.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Data
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ApprovalLineVo {

	private int approval_line_id;
	private String approval_id;
	private String recipient_id;
	private String recipient_type;
	private int step;
	private int status;
	private String approval_date;
	private String signature;
	private String rejection;
	private String recipient_name;
	private String rank_name;

}
