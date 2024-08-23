package com.pro.sync.approval.controller;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONArray;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.pro.sync.approval.service.IApprovalService;
import com.pro.sync.approval.vo.ApprovalLineVo;
import com.pro.sync.approval.vo.ApprovalVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller 
@RequestMapping(value = "/approval")
@Slf4j
@RequiredArgsConstructor
public class ApprovalController {

	private final IApprovalService approvalService;
	
	//Home -> 작성화면 이동
	@GetMapping(value = "/write.do")
	public String write() {
		log.info("기안서 작성 화면 요청");
		return "approval/write";
	}
	
	
	//작성화면에서 form 화면 부르기 ajax
	@GetMapping("/form.do")
	public String form(@RequestParam String id) {
		log.info("기안서 작성 시 화면 form 요청");
		
		if(id.equals("list001")) {
			//휴가신청서
			return "approval_document/leaveApplicationForm";
		} else {
			return "approval_document/go_away";
		}
		
	}
	
	
	//결재 상신
	@PostMapping("/approvalSubmit.do")
	public String approval_form(RedirectAttributes redirectAttributes, HttpSession session, @RequestParam Map<String, String> inMap, @RequestParam(required = false) List<String> referrer) {
	
		ApprovalVo approval = new ApprovalVo();
		
		//세션정보 가져오기 (사원번호, 소속부서, 기안일자)
		approval.setRequester_id("A001");
		log.info("{},{}",inMap,referrer);
		
		//화면에서 받은값, 결재자정보 보내기
		int n = approvalService.requestApproval(approval, inMap, referrer);
		if(n>0) {
			redirectAttributes.addFlashAttribute("message", "결재상신 완료");
			redirectAttributes.addFlashAttribute("details", "결재 요청이 성공적으로 전송되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "결재상신 실패");
		}
		return "redirect:/approval/write.do";
	}
	
	
	//결재 임시저장
	@PostMapping(value = "/approvalTemporarySave.do")
	public String tempSaveApproval(HttpSession session, @RequestParam Map<String, String> inMap, RedirectAttributes redirectAttributes) {
		
		ApprovalVo vo = new ApprovalVo();
		
		vo.setRequester_id("A002");
		vo.setDocument_type(inMap.remove("title"));
		
		log.info("안녕하세요 :{}", inMap);
		inMap.remove("approvalLine1");
		inMap.remove("approvalLine2");
		inMap.remove("approvalLine3");
		inMap.remove("referrer");

		vo.setApproval_content(new Gson().toJson(inMap));
		
		int n = approvalService.tempSaveApproval(vo);
		if(n>0) {
			redirectAttributes.addFlashAttribute("message", "임시저장 완료");
			redirectAttributes.addFlashAttribute("details", "문서가 임시 저장되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "임시저장 실패");
		}
		

		return "redirect:/approval/write.do";
	}
	
	
}
