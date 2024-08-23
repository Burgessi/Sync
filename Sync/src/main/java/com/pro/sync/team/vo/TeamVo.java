package com.pro.sync.team.vo;

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
public class TeamVo {

	private String team_code;
	private String team_name;
	private String upstairs_division_code;
	private String created_date;
	private String modified_date;
	private String deleted_date;
	private String delete_flag;

}
