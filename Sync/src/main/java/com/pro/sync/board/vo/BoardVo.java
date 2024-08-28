package com.pro.sync.board.vo;

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

public class BoardVo {

	private int bd_seq;
	private String emp_id;
	private String bd_title;
	private String bd_content;
	private int bd_post;
	private int bd_comment;
	private String bd_date;
	private String bd_del;
	
	private String employee_name;

}
