package com.pro.sync.reservations.ctrl;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Date;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pro.sync.employee.vo.EmployeeVo;
import com.pro.sync.facilities.service.IFacilitiesService;
import com.pro.sync.facilities.vo.FacilitiesVo;
import com.pro.sync.reservations.service.IReservationService;
import com.pro.sync.reservations.vo.ReservationsVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequiredArgsConstructor
@RequestMapping("rev")
public class ReservationsController {
	
	private final IFacilitiesService fservice;
	private final IReservationService service;
	
	@GetMapping(value = "/boardRev.do")
	public String boardRev(Model model, HttpSession session) {
		log.info("예약페이지 이동");
		
		// 포맷터 설정
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("MM-dd HH:mm");
		
		EmployeeVo loginDto = (EmployeeVo)session.getAttribute("loginDto");
		ReservationsVo rvo = new ReservationsVo();
		
		
		rvo.setEmp_id(loginDto.getEmp_id());
		List<FacilitiesVo> flist = fservice.selectFcl();
		List<ReservationsVo> mylist = service.selectMyRev(rvo.getEmp_id());
		List<ReservationsVo> useList = service.currentUseRev();
		
		
		
		 for (ReservationsVo vo : mylist) {
		        String startFormatted = vo.getRev_start().format(formatter);
		        String endFormatted = vo.getRev_end().format(formatter);
		        vo.setRevStartFormatted(startFormatted);
		        vo.setRevEndFormatted(endFormatted);
		    }
		 for (ReservationsVo ovo : useList) {
			 String startFormatted = ovo.getRev_start().format(formatter);
			 String endFormatted = ovo.getRev_end().format(formatter);
			 ovo.setRevStartFormatted(startFormatted);
			 ovo.setRevEndFormatted(endFormatted);
		 }

		log.info("flist넘겨주는 값 : {}", flist);
		log.info("mylist넘겨주는 값 : {}", mylist);
		log.info("use넘겨주는 값 : {}", useList);
		log.info("넘겨주는 값 : {}", LocalDateTime.now());
		
		
		model.addAttribute("flist", flist);
		model.addAttribute("mylist", mylist);
		model.addAttribute("useList", useList);
		model.addAttribute("currentTime", LocalDateTime.now());
		
		return "reservations/boardRev";
	}
	
	@PostMapping(value = "/insertRev.do")
	@Transactional
	public String insertRev(ReservationsVo rvo, RedirectAttributes rediAtt) {
		log.info("화면에서 오는 값 : {}", rvo);
		
		ReservationsVo inRev = new ReservationsVo();
		inRev.setEmp_id(rvo.getEmp_id());
		inRev.setFcl_id(rvo.getFcl_id());
		inRev.setRev_start(rvo.getRev_start());
		inRev.setRev_end(rvo.getRev_end());
		
		if (rvo.getRev_start().isAfter(rvo.getRev_end())) {
		    log.error("예약 시작 시간이 종료 시간보다 늦습니다.");
		    rediAtt.addFlashAttribute("message", "예약 시작 시간이 종료 시간보다 늦습니다.");
		    rediAtt.addFlashAttribute("messageType", "warning");
		    return "redirect:/rev/boardRev.do";
		}

		int over = service.selectOverlap(inRev);
		log.info("중복 값 : {}", over);
		
		if(over == 0) {
			boolean insertRev = service.insertRev(inRev);
			if(insertRev) {
				log.info("예약 성공");
			    rediAtt.addFlashAttribute("message", "등록됐습니다.");
			    rediAtt.addFlashAttribute("messageType", "success");
				return "redirect:/rev/boardRev.do";
			}else {
				log.info("예약 실패");
				rediAtt.addFlashAttribute("message", "등록이 안됐습니다.");
			    rediAtt.addFlashAttribute("messageType", "error");
				return "redirect:/rev/boardRev.do";
			}
		}else {
			log.info("중복예약발견");
			rediAtt.addFlashAttribute("message", "중복예약이 있습니다.");
		    rediAtt.addFlashAttribute("messageType", "warning");
			return "redirect:/rev/boardRev.do";
		}
	}
	
	@PostMapping(value = "/deleteRev.do")
	public String deleteRev(@RequestParam List<String> chk) {
		log.info("삭제될 예약 : {}", chk);
		int n = service.deleteRev(chk);
		log.info("삭제여부 성공 : 1, 실패 : 0 => {}", n);
		return "redirect:/rev/boardRev.do";
	}
	
	@GetMapping(value = "/allSelectRev.do")
	public String allSelectRev(Model model) {
		List<ReservationsVo> revList = service.currentUseRev();
		
		Map<String, String> colorMap = new HashMap<>();
		colorMap.put("회의실 103", "#7FFFD4");
		colorMap.put("회의실 102", "#00FFFF");
		colorMap.put("회의실 201", "#50B4FF");
		colorMap.put("회의실 204", "#FFF978");
		colorMap.put("회의실 302", "#FA8C8C");
		colorMap.put("회의실 401", "#F5D08A");
		
		for(ReservationsVo rvo : revList) {
			String colorVal = colorMap.get(rvo.getFcl_name());
			if(colorVal == null) {
				colorVal = "#fff";
			}
			rvo.setColor(colorVal);
		}
		log.info("보내는 리스트 : {}", revList);
		
		model.addAttribute("revList", revList);
		return "reservations/allSelectRev";
	}

}
