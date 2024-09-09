package com.pro.sync.board.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Param;

import com.pro.sync.board.vo.BoardVo;
import com.pro.sync.board.vo.FileBoardVo;

public interface IBoardDao {

	//전체글 보기
	public List<BoardVo> selectBoard(int startIndex, int pageSize);
	
	//댓글 제외 공지사항 갯수
	public int totalCount();
	
	//게시글 상세보기
	public BoardVo detailBoard(String bd_seq);
	
	//게시글 삭제
	public int deleteBoard(List<String> bd_seqs);
	
	//게시글 수정
	public boolean modifyBoard(Map<String, Object>map);
	
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
	
	//게시글 작성 
	public boolean insertBoard(BoardVo bvo);
	
	//파일 등록
	public boolean fileInsert(@Param("list") List<FileBoardVo> fileList, @Param("bd_seq") int bd_seq, @Param("emp_id") String emp_id);
	
	//파일 삭제 
	public int deleteFile(int file_seq);
	
	//파일 조회
	public FileBoardVo selectFile(int file_seq);
	
	//댓글 작성자 id
	public String getBoardAuthorId(int bd_seq);
	
	
	
	
}
