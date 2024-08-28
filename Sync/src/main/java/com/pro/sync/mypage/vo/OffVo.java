package com.pro.sync.mypage.vo;

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
@AllArgsConstructor
@NoArgsConstructor
public class OffVo {

	private String off_history_id;
	private String off_date;
	private String off_reason;
	private String emp_id;
}
