
package com.pro.sync.employee.vo;


import com.pro.sync.division.vo.DivisionVo;
import com.pro.sync.mypage.vo.AccountVo;
import com.pro.sync.team.vo.TeamVo;

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
public class EmployeeVo {

	private String emp_id;
	private String emp_name;
	private String emp_password;
	private String emp_gender;
	private String emp_ssn;
	private String emp_email;
	private String emp_phone;
	private String addr1;
	private String addr2;
	private String emp_hire_date;
	private String emp_leaving_date;

	private String emp_status;
	private String emp_profile_pic;
	private String team_code;
	private String rank_id;
	private String authority;

	private String emp_lead;
	private String emp_signature;
	private int total_off;
	
	private String team_name;
	private String division_name;
	private String rank_name;
	
	private int used_off;
	
	private String bank_name;
	private String relation_to_emp;
	private String account_num;
	
	private TeamVo teamVo;
	
	private DivisionVo divisionVo;
	
	private String certi_type;  //재직증명서 발급 용도
	private int total_certi; //재직증명서 총 개수
	private int used_certi; //재직증명서 출력 부수
	
	
	

	
}

