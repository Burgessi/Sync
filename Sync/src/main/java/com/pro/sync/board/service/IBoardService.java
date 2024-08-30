package com.pro.sync.board.service;

import java.util.List;
import java.util.Map;

import com.pro.sync.board.vo.BoardVo;

public interface IBoardService {
	
	//전체글 보기
	public List<BoardVo> selectBoard(int startIndex, int pageSize);

	//댓글 제외 공지사항 갯수
	public int totalCount();
	
	//게시글 상세보기
	public BoardVo detailBoard(String bd_seq);
	
	//게시글 삭제
	public int deleteBoard(List<String> bd_seqs);
	
	//댓글 
	public int insertComment(BoardVo vo);
	
	//댓글 리스트 
	public List<BoardVo> selectComment(String bd_seq);
	
	//댓글 삭제
	public int deleteComment(Map<String, Object> map);
	
	//댓글 수정
	public int modifyComment(Map<String, Object> map);
	
	//게시글 검색
	public List<BoardVo> searchBoard(Map<String, Object> map);
}
