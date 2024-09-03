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
public class FileBoardVo {
	
	private String file_seq;
	private String file_oname;
	private String file_sname;
	private int file_size;
	private String file_date;
	private String file_del;
	private String file_category;
	private int bd_seq;
	private String emp_id;
	private int approval_id;
	private byte[] file_data;
	
	

}
