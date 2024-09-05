package com.pro.sync.reservations.vo;

import java.time.LocalDateTime;

import org.springframework.format.annotation.DateTimeFormat;

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

public class ReservationsVo {

	private int rev_id;
	
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private LocalDateTime rev_start;
	
	@DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME)
	private LocalDateTime rev_end;
	
	private String emp_id;
	
	//시설 
	private int fcl_id;
	private String fcl_name;
	
	private String revStartFormatted;
	private String revEndFormatted;
	private String team_name;
	private String color;
	
}
