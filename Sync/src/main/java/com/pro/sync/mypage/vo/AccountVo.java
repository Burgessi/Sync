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
public class AccountVo {
	
	private String account_id;
	private String bank_name;
	private String account_num;
	private String account_holder;
	private String relation_to_emp;
	private String emp_id;
	
}
