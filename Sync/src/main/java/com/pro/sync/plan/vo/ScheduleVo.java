package com.pro.sync.plan.vo;

import java.time.LocalDateTime;

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
public class ScheduleVo {

	private int scd_no;
	private String team_code;
	private String artist_id;
	private LocalDateTime scd_start; // LocalDate -> LocalDateTime 변경
    private LocalDateTime scd_end;   // LocalDate -> LocalDateTime 변경
	private String scd_title;
	private String scd_content;
	private String scd_color;

}
