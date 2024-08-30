package com.pro.sync.approval.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.google.gson.Gson;
import com.pro.sync.approval.service.IApprovalService;
import com.pro.sync.approval.vo.ApprovalLineVo;
import com.pro.sync.approval.vo.ApprovalVo;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller 
@RequestMapping(value = "/approval")
@Slf4j
@RequiredArgsConstructor
public class ApprovalController {

	private final IApprovalService approvalService;
	
	// 사이드바 -> 결재 메인
	@GetMapping("/main.do")
	public String main() {
		return "approval/main";
	}
	
	@GetMapping("/progress.do")
	// 사이드바 -> 기안문서함
	public String progress(HttpSession session, Model model) {
		EmployeeVo loginVo = (EmployeeVo)session.getAttribute("loginDto");
		String id = loginVo.getEmp_id();
		String empName = loginVo.getEmp_name();
		log.info(empName);
		List<ApprovalVo> myApprovalList = approvalService.getApprovalsList(id);
		model.addAttribute("myApprovalList", myApprovalList);
		model.addAttribute("empName", empName);
		log.info("[myApprovalList] : {}",myApprovalList);
		return "approval/progress";
	}
	
	
	//결재 상세 조회 페이지
	@GetMapping("/getApprovalDetail.do")
	public String getApprovalDetail(HttpSession session, String approval_id, String requester_id, String document_type, String temp_save_flag, Model model){
		log.info("받은값 : {},{},{}", approval_id, requester_id, document_type);
		Map<String, String> info = new HashMap<String, String>();
		//상세정보 가져올 문서번호, 양식, 결재요청자의 id
		info.put("requester_id", requester_id);
		info.put("approval_id", approval_id);
		info.put("document_type", document_type);
		
		// 임시저장이 아닌경우의 상세조회
		if(temp_save_flag.equals("N")) {
			ApprovalVo approvalDetail = approvalService.getApprovalDetail(info);
			model.addAttribute("approvalDetail", approvalDetail);
			log.info("임시서장 아닌 경우 상세조회 [approvalDetail]: {}", approvalDetail);
			
		// 임시저장인 경우 상세조회
		} else {
			ApprovalVo tempApproval = approvalService.getTempApprovalDetail(info);
			model.addAttribute("approvalDetail", tempApproval);
			log.info("임시서장인경우 상세조회 [approvalDetail]: {}", tempApproval);
		}
		
		switch (document_type) {
			case "휴가신청서": return "approval/approvalDetail/leaveApplicationDetail";
			case "출장보고서": return "approval/approvalDetail/businessTripReportDetail";
			case "지출결의서": return "approval/approvalDetail/expenseReportDetail";
			default: return "approval/approvalDocument/go_away";
		}
		
	}

	//상세 -> 수정페이지 이동(결재 내용 들고가기)
	@GetMapping("/modifyApproval.do")
	public String modifyApproval(HttpSession session, String document_type, String approval_id, Model model, String temp_save_flag) {
		log.info("전달 결재id :{}", approval_id);
		Map<String, String> info = new HashMap<String, String>();
		EmployeeVo loginVo = (EmployeeVo)session.getAttribute("loginDto");
		info.put("requester_id", loginVo.getEmp_id());
		info.put("document_type", document_type);
		info.put("approval_id", approval_id);
		
		if(temp_save_flag.equals("N")) {
			ApprovalVo approval = approvalService.getApprovalDetail(info);
			model.addAttribute("approval", approval);
			log.info("상세->수정페이지 이동 temp_save_flag가 N인경우 : 전달 값 approval : {}", approval);
		} else {
			ApprovalVo tempApproval = approvalService.getTempApprovalDetail(info);
			model.addAttribute("approval", tempApproval);
			log.info("상세->수정페이지 이동 temp_save_flag가 Y인경우 : 전달 값 approval : {}", tempApproval);
		}
		
		switch (document_type) {
			case "휴가신청서": return "approval/approvalModification/leaveApplicationModification";
			case "출장보고서": return "approval/approvalModification/businessTripModification";
			case "지출결의서": return "approval/approvalModification/expenseReportModification";
			default: return "approval/approvalDocument/leaveApplicationForm";
		}
		
	}
	
	// 수정 확인 필요 값 :결재id, title, content  ==>   수정 완료 후 상세페이지로 이동 
	// getApprovalDetail.do 상세정보 얻기위해서 document_type, approval_id 필요
	@PostMapping("/modifyApproval.do")
	public String modifyApproval(@RequestParam Map<String, String> inMap, RedirectAttributes redirectAttributes, Model model) {
		log.info("modifyApproval 받은 값: {}", inMap);
		String approval_id = inMap.remove("approvalId");
		String document_type = inMap.remove("documentType");
		String approval_title = inMap.remove("title");
		String temp_save_flag = inMap.remove("temp_save_flag");
		String requester_id = inMap.remove("requester_id");
		
		Map<String, String> info = new HashMap<String, String>();
		info.put("approval_id", approval_id);
		info.put("approval_title", approval_title);
		info.put("approval_content", new Gson().toJson(inMap));
		
		//만약 N이라면 >> 일반 수정..
		if(temp_save_flag.equals("N")) {
			approvalService.modifyApproval(info);
		} else { //Y라면 임시저장의 경우..
			
		}
		
		
		
		redirectAttributes.addAttribute("approval_id",approval_id);
		redirectAttributes.addAttribute("document_type",document_type);
		redirectAttributes.addAttribute("temp_save_flag", temp_save_flag);
		redirectAttributes.addAttribute("requester_id", requester_id);
		redirectAttributes.addFlashAttribute("message", "문서수정 완료");
		redirectAttributes.addFlashAttribute("details", "문서 수정이 성공적으로 완료되었습니다.");
		
		return "redirect:/approval/getApprovalDetail.do";
	}
	
	
	
	//상세 -> 삭제
	@GetMapping("/deleteApproval.do")
	public String deleteApproval(RedirectAttributes redirectAttributes, String approval_id) {
		Map<String, String> flag = new HashMap<String, String>();
		String delete_flag = "Y";
		flag.put("approval_id", approval_id);
		flag.put("delete_flag", delete_flag);
		
		approvalService.updateApprovalFlag(flag);
		redirectAttributes.addFlashAttribute("message", "문서회수 완료");
		redirectAttributes.addFlashAttribute("details", "작성한 문서가 회수되었습니다.");
		return "redirect:/approval/progress.do";
	}
	
	
	@GetMapping("/receive.do")
	// 사이드바 -> 결재수신함
	public String receive(HttpSession session, Model model) {
		EmployeeVo loginVo = (EmployeeVo)session.getAttribute("loginDto");
		String loginId = loginVo.getEmp_id();
		List<ApprovalVo> myApprovalList = approvalService.getAllReceivedApproval(loginId);
		model.addAttribute("myApprovalList", myApprovalList);
		return "approval/receive";
	}
	
	// 사이드바 -> 임시저장함
	@GetMapping("/tempsave.do")
	public String tempsave(HttpSession session, Model model) {
		EmployeeVo loginVo = (EmployeeVo)session.getAttribute("loginDto");
		String id = loginVo.getEmp_id();
		List<ApprovalVo> tempApproval = approvalService.getTempSaveList(id);
		model.addAttribute("tempApproval", tempApproval);
		return "approval/tempsave";
	}
	
	// Home -> 결재 작성화면 이동
	@GetMapping(value = "/write.do")
	public String write(HttpSession session, Model model) {
		log.info("기안서 작성 화면 요청");
		EmployeeVo loginVo = (EmployeeVo)session.getAttribute("loginDto");
		model.addAttribute("loginVo", loginVo);
		return "approval/write";
	}
	
	
	//작성화면에서 form 화면 부르기 ajax
	@GetMapping("/form.do")
	public String form(@RequestParam String form, HttpSession session, Model model) {
		log.info("기안서 작성 시 화면 form 요청");
		
		EmployeeVo loginVo = (EmployeeVo)session.getAttribute("loginDto");
		model.addAttribute("loginVo", loginVo);
		
		
		switch (form) {
		case "form001": return "approval/approvalDocument/leaveApplicationForm";
		case "form002": return "approval/approvalDocument/businessTripReportForm";
		case "form003": return "approval/approvalDocument/expenseReportForm";
		default: return "approval/approvalDocument/leaveApplicationForm";
		}
		
	}
	
	//임시저장 결재상신
	@PostMapping("/tempApprovalSubmit.do")
	public String tempApprovalSubmit(RedirectAttributes redirectAttributes, HttpSession session, @RequestParam Map<String, String> inMap, @RequestParam(required = false) List<String> referrer) {
		
		log.info("임시저장 문서 제출 {},{}",inMap,referrer);
		
		approvalService.requestTempApproval(inMap, referrer);
		
		redirectAttributes.addFlashAttribute("message", "결재상신 완료");
		redirectAttributes.addFlashAttribute("details", "결재 요청이 성공적으로 전송되었습니다.");
		
		return "redirect:/approval/tempsave.do";
	}
	
	
	
	//결재 상신
	@PostMapping("/approvalSubmit.do")
	public String approvalSubmit(RedirectAttributes redirectAttributes, HttpSession session, @RequestParam Map<String, String> inMap, @RequestParam(required = false) List<String> referrer) {
	
		ApprovalVo approval = new ApprovalVo();
		
		//세션정보 가져오기 (사원번호, 소속부서, 기안일자)
		EmployeeVo loginVo = (EmployeeVo)session.getAttribute("loginDto");
		String id = loginVo.getEmp_id();
		approval.setRequester_id(id);
		
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
		
		ApprovalVo approval = new ApprovalVo();
		EmployeeVo loginVo = (EmployeeVo)session.getAttribute("loginDto");
		String id = loginVo.getEmp_id();
		
		String title = inMap.remove("title");
		
		approval.setRequester_id(id);
		approval.setDocument_type(inMap.remove("documentType"));
		approval.setApproval_title(title);
		
		log.info(title);
		
		log.info("안녕하세요 :{}", inMap);
		inMap.remove("approvalLine1");
		inMap.remove("approvalLine2");
		inMap.remove("approvalLine3");
		inMap.remove("referrer");

		approval.setApproval_content(new Gson().toJson(inMap));
//		return "";
		int n = approvalService.tempSaveApproval(approval);
		if(n>0) {
			redirectAttributes.addFlashAttribute("message", "임시저장 완료");
			redirectAttributes.addFlashAttribute("details", "임시 저장되었습니다.");
		} else {
			redirectAttributes.addFlashAttribute("message", "임시저장 실패");
		}
		

		return "redirect:/approval/write.do";
	}
	
	
	
	
	
	
}
