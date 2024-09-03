package com.pro.sync.facilities.vo;

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

public class FacilitiesVo {

	private int fcl_id;
	private String fcl_name;
	private String fcl_able;
	private String fcl_pic;
	private String fcl_content;

}
