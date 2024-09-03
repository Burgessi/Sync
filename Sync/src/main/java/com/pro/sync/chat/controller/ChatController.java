package com.pro.sync.chat.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.ServletConfigAware;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/chat")
public class ChatController implements ServletConfigAware{
	
	
	private ServletContext servletContext;
	
	
	@Override
	public void setServletConfig(ServletConfig servletConfig) {
		servletContext = servletConfig.getServletContext();
	}
	

	@GetMapping("/main.do")
	public String chat() {
		log.info("채팅방 이동 main.do");
		return "/chat/main";
	}
	
	
	@GetMapping(path = "/socketOpen.do")
	@ResponseBody
	public String socketOpen(@RequestParam String empId, String grId, String empName, HttpSession session) {
		
		session.setAttribute("grId", grId);
		session.setAttribute("empId", empId);
		session.setAttribute("empName", empName);
		
		log.info("grid: {}" , grId);
		log.info("empId: {}" , empId);
		log.info("empName: {}" , empName);
		
		Map<String, String> chatList = (Map<String, String>)servletContext.getAttribute("chatList");
		if(chatList == null) {
			chatList = new HashMap();
			chatList.put(empId, grId);
			servletContext.setAttribute("chatList", chatList);
		} else {
			chatList.put(empId, grId);
			servletContext.setAttribute("chatList", chatList);
		}
		log.info("ChatController 웹소켓 목록 : {}", servletContext.getAttribute("chatList"));
		
		return "true";
	}


	
	
	
	
}
