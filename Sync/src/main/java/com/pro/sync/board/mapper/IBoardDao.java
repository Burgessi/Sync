package com.pro.sync.board.mapper;

import java.util.List;

import com.pro.sync.board.vo.BoardVo;

public interface IBoardDao {

	//전체글 보기
	public List<BoardVo> selectBoard(int startIndex, int pageSize);
	
	//댓글 제외 공지사항 갯수
	public int totalCount();
	
	//게시글 상세보기
	public BoardVo detailBoard(String bd_seq);
	
}
