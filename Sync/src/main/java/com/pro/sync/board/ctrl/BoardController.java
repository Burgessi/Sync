package com.pro.sync.board.ctrl;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.pro.sync.board.service.IBoardService;
import com.pro.sync.board.vo.BoardVo;
import com.pro.sync.common.service.PagingService;
import com.pro.sync.common.vo.PagingVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/board")
public class BoardController {
	
	private final IBoardService service;
	private final PagingService pservice;
	
	//게시글 전체 조회
	@GetMapping(value = "/userBoard.do")
	public String userBoard(@RequestParam(value = "page", defaultValue  = "1") int page,
            				@RequestParam(value = "countRow", defaultValue = "10") int countRow,
            				@RequestParam(value = "countPage", defaultValue = "5") int countPage,
            				Model model){
		log.info("자유게시판으로 이동");
		
		int boardCount = service.totalCount();
		List<BoardVo> blist = service.selectBoard(page, countRow);
		
		PagingVo paging = pservice.page(countPage, boardCount, countRow, page);
		model.addAttribute("blist", blist);
		model.addAttribute("paging", paging);
		return "board/userBoard";
	}
	
	//게시글 상세
	@GetMapping(value = "/detailBoard.do")
	public String detailBoard(Model model, String bd_seq) {
		log.info("{}번 게시글 상세보기", bd_seq);
		BoardVo detail = service.detailBoard(bd_seq);
		model.addAttribute("detail", detail);
		return "board/detailBoard";
	}

}
