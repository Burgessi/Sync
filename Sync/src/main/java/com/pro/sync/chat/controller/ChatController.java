package com.pro.sync.chat.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;

import com.pro.sync.chat.service.IChatService;
import com.pro.sync.chat.vo.ChatRoomVo;
import com.pro.sync.chat.vo.ChatVo;
import com.pro.sync.employee.vo.EmployeeVo;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
@RequiredArgsConstructor
public class ChatController implements ServletConfigAware{
	
	
	private ServletContext servletContext;
	
	private final IChatService chatService;
	
	@Override
	public void setServletConfig(ServletConfig servletConfig) {
		servletContext = servletConfig.getServletContext();
	}
	

	
	
	@GetMapping("/main.do")
	public String chat(HttpSession session, Model model) {
		log.info("채팅방 이동 main.do");
		EmployeeVo employeeVo = (EmployeeVo)session.getAttribute("loginDto");
		List<ChatRoomVo> chatList = chatService.getAllChatList(employeeVo.getEmp_id());
		model.addAttribute("chatList", chatList);
		return "/chat/main";
	}
	
	
	
	
	//채팅 메세지 보내기전 소켓열기
	@GetMapping(path = "/socketOpen.do")
	@ResponseBody
	public List<ChatVo> socketOpen(@RequestParam String empId, String chatroomId, String empName, HttpSession session) {
		
		session.setAttribute("chatroomId", chatroomId);
		session.setAttribute("empId", empId);
		session.setAttribute("empName", empName);
		
		log.info("chatroomId: {}" , chatroomId);
		log.info("empId: {}" , empId);
		log.info("empName: {}" , empName);
		
		Map<String, String> chatList = (Map<String, String>)servletContext.getAttribute("chatList");
		if(chatList == null) {
			chatList = new HashMap();
			chatList.put(empId, chatroomId);
			servletContext.setAttribute("chatList", chatList);
		} else {
			chatList.put(empId, chatroomId);
			servletContext.setAttribute("chatList", chatList);
		}
		log.info("ChatController 웹소켓 목록 : {}", servletContext.getAttribute("chatList"));
		
		List<ChatVo> chat = chatService.getAllChatContent(Integer.parseInt(chatroomId));
		log.info("최종 전달 chat 내역:{}", chat);
		return chat;
	}


	
	
	
	
}
