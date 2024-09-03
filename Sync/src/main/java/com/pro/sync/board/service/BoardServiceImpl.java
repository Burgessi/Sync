package com.pro.sync.board.service;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.pro.sync.board.mapper.IBoardDao;
import com.pro.sync.board.vo.BoardVo;
import com.pro.sync.board.vo.FileBoardVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements IBoardService {
	
	private final IBoardDao dao;

	@Override
	public List<BoardVo> selectBoard(int page, int countRow) {
		log.info("자유게시판 전체글 보기");
		int startIndex = (page - 1) * countRow + 1;
		return dao.selectBoard(startIndex, countRow);
	}

	@Override
	public int totalCount() {
		return dao.totalCount();
	}

	@Override
	public BoardVo detailBoard(String bd_seq) {
		log.info("게시글 상세보기");
		return dao.detailBoard(bd_seq);
	}

	@Override
	public int deleteBoard(List<String> bd_seqs) {
		log.info("게시글 삭제");
		return dao.deleteBoard(bd_seqs);
	}

	@Override
	public int insertComment(BoardVo vo) {
		log.info("댓글 생성");
		return dao.insertComment(vo);
	}

	@Override
	public List<BoardVo> selectComment(String bd_seq) {
		log.info("댓글 리스트");
		return dao.selectComment(bd_seq);
	}

	@Override
	public int deleteComment(Map<String, Object> map) {
		log.info("댓글 삭제");
		return dao.deleteComment(map);
	}

	@Override
	public int modifyComment(Map<String, Object> map) {
		log.info("댓글 수정");
		return dao.modifyComment(map);
	}

	@Override
	public List<BoardVo> searchBoard(Map<String, Object> map) {
		log.info("제목 or 작성자 검색");
		return dao.searchBoard(map);
	}

	@Override
	public boolean insertBoard(BoardVo bvo) {
		log.info("게시글 등록");
		return dao.insertBoard(bvo);
	}

	@Override
	public boolean fileInsert(List<FileBoardVo> fileList, int bd_seq, String emp_id) {
		log.info("파일등록");
		return dao.fileInsert(fileList, bd_seq, emp_id);
	}

	@Override
	public boolean modifyBoard(Map<String, Object> map) {
		log.info("게시글 수정");
		return dao.modifyBoard(map);
	}

	@Override
	public int deleteFile(int file_seq) {
		log.info("파일 삭제");
		return dao.deleteFile(file_seq);
	}

	@Override
	public FileBoardVo selectFile(int file_seq) {
		log.info("선택 파일 조회");
		return dao.selectFile(file_seq);
	}
	
	
	
	
	
	

}
