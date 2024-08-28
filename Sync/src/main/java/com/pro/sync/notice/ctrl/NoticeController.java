package com.pro.sync.notice.ctrl;


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
import com.pro.sync.common.service.PagingService;
import com.pro.sync.common.vo.PagingVo;
import com.pro.sync.employee.vo.EmployeeVo;
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
	
	private final PagingService pservice;
	
	//공지 게시글 불러오기
	@GetMapping(value = "/noticeBoard.do")
	public String noticeBoard(@RequestParam(value = "page", defaultValue  = "1") int page,
	                          @RequestParam(value = "countRow", defaultValue = "10") int countRow, // 수정
	                          @RequestParam(value = "countPage", defaultValue = "5") int countPage, // 수정
	                          Model model) {
	    log.info("공지사항으로 이동");
	    
	    int totalCount = service.totalCount();
	    List<NoticeVo> lists = service.selectNotice(page, countRow);
	    
	    PagingVo paging = pservice.page(countPage, totalCount, countRow, page); // 수정
	    model.addAttribute("lists", lists);
	    model.addAttribute("paging", paging);
	    
	    return "notice/noticeBoard";
	}
	
	//공지 게시글 삭제
	@RequestMapping(method = {RequestMethod.GET, RequestMethod.POST}, value = "/deleteNotice.do")
	public String deleteNotice(@RequestParam List<String> chk) {
		log.info("삭제될 게시물 번호 : {}", chk);
		
		int n = service.deleteNotice(chk);
		log.info("결과 : {}", n);
		return "redirect:/notice/noticeBoard.do";
	}

	//공지 게시글 상세보기 
	@GetMapping(value = "/detailNotice.do")
	public String detailNotice(String notice_seq, Model model) {
		log.info("{}번 게시글 상세보기 ", notice_seq);
		NoticeVo noti = service.detailNotice(notice_seq);
		model.addAttribute("noti", noti);
		return "notice/detailNotice";
	}
	
	//공지 게시글 수정페이지 이동
	@GetMapping(value = "/modifyNotice.do")
	public String modifyNotice(@RequestParam("notice_seq") String notice_seq, Model model, HttpSession session) {
		EmployeeVo loginDto = (EmployeeVo)session.getAttribute("loginDto");
		NoticeVo no = service.detailNotice(notice_seq);
		log.info("{}",no.getEmp_id());
		if(no.getEmp_id().equals(loginDto.getEmp_id())) {
			model.addAttribute("no", no);
			return "notice/modifyNotice";
		} else {
			return "redirect:/notice/noticeBoard.do";
		}
		
	}
	
	//공지 게시글 수정 
	@PostMapping(value = "/modifyNotice.do")
	public String modifyNotice(@RequestParam Map<String, Object> map, HttpSession session) {
		EmployeeVo loginDto = (EmployeeVo)session.getAttribute("loginDto");
		map.put("emp_id", loginDto.getEmp_id());
		boolean isc = service.modifyNotice(map);
		if(isc) {
			return "redirect:/notice/detailNotice.do?notice_seq=" + map.get("notice_seq");
		} else {
			return "redirect:/notice/modifyNotice.do?notice_seq=" + map.get("notice_seq");
		}
	}
		
	//공지 고정
	@PostMapping(value = "/noticePin.do")
	@ResponseBody
	@Transactional
	public String noticePin(@RequestParam List<String> chk) {
	    log.info("넘어온 값 : {}", chk);
	    
	    int m = service.cntPin();
	    int n = chk.size();
	    
	    if (m + n <= 5) {
	        int isc = service.noticePin(chk);
	        log.info("값 : {}", isc);
	        if (isc > 0 && isc <= 5) {
	            return "success";
	        } else {
	            return "fail";
	        }
	    } else {
	        return "fail"; // 최대 개수 초과 시 "fail"
	    }
	}
	
	
	@PostMapping(value = "/noticePinCancel.do")
	@ResponseBody
	public String noticePinCancel(@RequestParam List<String> chk) {
		log.info("넘어온 리스트 넘버 : {}", chk);
		
		int c = service.noticePinCancel(chk);
		
		if(c > 0) {
			return "success";
		} else {
			return "fail";
		}
	}
	
	//공지 게시글 검색
	@PostMapping(value="/searchNotice.do")
	@ResponseBody
	public String searchNotice(@RequestParam Map<String, Object> map) {
	    log.info("검색 : {}", map);
	    List<NoticeVo> search = service.searchNotice(map);
	    
	    Gson gson = new GsonBuilder().create();
	    
	    return gson.toJson(search);
	}
	
	//게시글 생성 페이지 이동
	@GetMapping(value = "/insertNotice.do")
	public String insertNotice() {
		log.info("게시글 작성 페이지 이동");
		return "notice/insertNotice";
	}
	
	//게시글 생성 
	@PostMapping(value = "/insertNotice.do")
	public String insertNotice(NoticeVo vo, HttpSession session) {
		log.info("게시글 작성");
		EmployeeVo loginDto = (EmployeeVo)session.getAttribute("loginDto");
		vo.setEmp_id(loginDto.getEmp_id());
		int n = service.insertNotice(vo);
		return (n>0)?"redirect:/notice/detailNotice.do?notice_seq="+vo.getNotice_seq():"redirect:/notice/noticeBoard.do";
	}

}
