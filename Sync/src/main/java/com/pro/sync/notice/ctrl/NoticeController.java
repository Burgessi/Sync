package com.pro.sync.notice.ctrl;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.pro.sync.notice.service.INoticeService;
import com.pro.sync.notice.vo.NoticeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("/notice")
public class NoticeController {
	
	private final INoticeService service;
	
	@GetMapping(value = "/noticeBoard.do")
	public String noticeBoard(Model model) {
		log.info("공지사항으로 이동");
		List<NoticeVo> lists = service.selectNotice();
		model.addAttribute("lists", lists);
		return "notice/noticeBoard";
	}

}
