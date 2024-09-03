package com.pro.sync.attendance.vo;

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
public class AttendanceVo {

	private String attendance_id;
	private String emp_id;
	private String check_in_time;
	private String check_out_time;
	private int status;
	private String attendance_date;
}
