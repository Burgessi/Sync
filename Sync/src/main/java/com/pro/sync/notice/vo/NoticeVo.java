package com.pro.sync.notice.vo;

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

public class NoticeVo {

	private int notice_seq;
	private String notice_title;
	private String notice_content;
	private String notice_regdate;
	private String notice_delflag;
	private String notice_pinbtn;
	private String emp_id;

}
