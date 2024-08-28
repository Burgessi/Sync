package com.pro.sync.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.pro.sync.board.mapper.IBoardDao;
import com.pro.sync.board.vo.BoardVo;

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
	
	

}
