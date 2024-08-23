package com.pro.sync.division.vo;


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
public class DivisionVo {

	private String division_code;
	private String division_name;
	private String created_date;
	private String modified_date;
	private String deleted_date;
	private String delete_flag;

}
