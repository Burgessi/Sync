package com.pro.sync.board.ctrl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
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
	@Transactional
	public String detailBoard(Model model, String bd_seq) {
		log.info("{}번 게시글 상세보기", bd_seq);
		BoardVo detail = service.detailBoard(bd_seq);
		List<BoardVo> clist = service.selectComment(bd_seq);
		model.addAttribute("clist", clist);
		model.addAttribute("detail", detail);
		return "board/detailBoard";
	}
	
	//게시글 삭제
	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value="/deleteBoard.do")
	public String deleteBoard(@RequestParam List<String> chk) {
		log.info("삭제될 게시물 {}", chk);
		int n = service.deleteBoard(chk);
		log.info("결과 {}", n);
		return "redirect:/board/userBoard.do";
	}
	
	//댓글 생성
	@PostMapping(value = "/insertComment.do")
	public String insertComment(BoardVo vo, HttpSession session, String bd_seq) {
		log.info("댓글 생성 {}", vo);
		int n = service.insertComment(vo);
		
		return (n==1)?"redirect:/board/detailBoard.do?bd_seq="+vo.getBd_seq():"redirect:/board/userBoard.do";
	}
	
	//댓글 삭제
	@PostMapping(value = "/deleteComment.do")
	public String deleteComment(@RequestParam String co_post,
								@RequestParam String co_comment,
								@RequestParam String bd_seq) {
		log.info("삭제 댓글 post : {}, comment : {}, seq : {}",co_post ,co_comment, bd_seq);
		
		Map<String, Object> map = new HashMap<>();
		map.put("bd_post", co_post);
		map.put("bd_comment", co_comment);
		
		log.info("MAP 값{}", map);
		
		int n = service.deleteComment(map);
		log.info("결과 값{}", n);
		
		return (n>0)?"redirect:/board/detailBoard.do?bd_seq="+bd_seq:"redirect:/board/userBoard.do";
	}
	
	
	//댓글 수정 
	@PostMapping(value = "/modifyComment.do")
	public String modifyComment(@RequestParam String bd_seq,
								@RequestParam String co_post,
								@RequestParam String co_comment,
								@RequestParam String co_content) {
		log.info("받아오는 값 seq : {}, co_post : {}, co_comment : {}, co_content : {}", bd_seq, co_post, co_comment, co_content);
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("bd_post", co_post);
		maps.put("bd_comment", co_comment);
		maps.put("bd_content", co_content);
		
		int n = service.modifyComment(maps);
		log.info("보내는 값 : {}", maps);
		
		return (n>0)?"redirect:/board/detailBoard.do?bd_seq="+bd_seq:"redirect:/board/userBoard.do"; 
	}
	
	//게시물 검색
	@PostMapping(value = "/searchBoard.do")
	@ResponseBody
	public String searchBoard(@RequestParam Map<String, Object> map) {
		log.info("작성자 or 게시물 검색 : {}", map);
		List<BoardVo> searchBoard = service.searchBoard(map);
		
		Gson gson = new GsonBuilder().create();
		
		return gson.toJson(searchBoard);
	}
	
	//게시물 작성 페이지 이동
	@GetMapping(value = "/insertBoard.do")
	public String insertBoard() {
		log.info("게시물 작성 페이지 이동");
		return "board/insertBoard";
	}

}
