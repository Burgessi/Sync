package com.pro.sync.common.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Data
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class PagingVo {
	
	private int page; // 현재 페이지
	private int total; // 전체 게시글 갯수
	private int countRow; // 한 페이지당 보여질 갯수 ex) countRow = 15 => 15개의 글이 보임
	private int countPage; // 하단에 보여질 페이지 갯수 ex) countPage = 5 => < 1 2 3 4 5 >
	private int totalPage; // 총 페이지 수
	private int startPage; // 그룹 시작 페이지 번호
	private int endPage; // 그룹 끝 페이지 번호

}
