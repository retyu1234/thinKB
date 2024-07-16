package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IdeaRoomController {
	
	@RequestMapping("/newIdeaRoom")
	public String newIdeaRoom(Model model) {
		return "ideaRoom/newRoom";
	}
	
	@RequestMapping("/makeRoom")
	public String makeRoom(HttpServletRequest request, Model model) {
		System.out.println("makeRoom() 실행");
		System.out.println("id : " + request.getParameter("id"));
		System.out.println("title : " + request.getParameter("title"));
		System.out.println("content : " + request.getParameter("content"));
		System.out.println("endDate : " + request.getParameter("endDate"));
		System.out.println("timer_hours : " + request.getParameter("timer_hours"));
		System.out.println("timer_minutes : " + request.getParameter("timer_minutes"));
		System.out.println("timer_seconds : " + request.getParameter("timer_seconds"));
		return "main";
	}

}
