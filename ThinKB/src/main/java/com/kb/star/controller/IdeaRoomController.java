package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.command.room.UserListCommand;
import com.kb.star.command.room.makeRoomCommand;

@Controller
public class IdeaRoomController {
	
	RoomCommand command = null;
	public SqlSession sqlSession;
	
	@Autowired
	public IdeaRoomController(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	// 메인에서 회의방 생성버튼 눌렀을때, 동일 부서직원 목록 조회, 저장해서 view로 이동
	@RequestMapping("/newIdeaRoom")
	public String newIdeaRoom(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("userName");
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("name", name);
		model.addAttribute("id", id);
		command = new UserListCommand(sqlSession);
		command.execute(model);
		return "ideaRoom/newRoom";
	}
	
	@RequestMapping("/makeRoom")
	public String makeRoom(HttpServletRequest request, Model model) {
//		System.out.println("makeRoom() 실행");
//		System.out.println("id : " + request.getParameter("id"));
//		System.out.println("title : " + request.getParameter("title"));
//		System.out.println("content : " + request.getParameter("content"));
//		System.out.println("endDate : " + request.getParameter("endDate"));
//		System.out.println("timer_hours : " + request.getParameter("timer_hours"));
//		System.out.println("timer_minutes : " + request.getParameter("timer_minutes"));
//		System.out.println("timer_seconds : " + request.getParameter("timer_seconds"));
//		System.out.println("users : " + request.getParameter("users"));
//		model.addAttribute("id", request.getParameter("id"));
//		model.addAttribute("title", request.getParameter("title"));
//		model.addAttribute("content", request.getParameter("content"));
//		model.addAttribute("endDate", request.getParameter("endDate"));
//		model.addAttribute("timer_hours", request.getParameter("timer_hours"));
//		model.addAttribute("timer_minutes", request.getParameter("timer_minutes"));
//		model.addAttribute("timer_seconds", request.getParameter("timer_seconds"));
//		model.addAttribute("users", request.getParameter("users"));
		model.addAttribute("request", request);
		command = new makeRoomCommand(sqlSession);
		command.execute(model);
		return "main";
	}
	
//	@RequestMapping("/employees")
//	public String employees(HttpServletRequest request, Model model) {
//		HttpSession session = request.getSession();
//		String name = (String) session.getAttribute("userName");
//		model.addAttribute("name", name);
//		command = new UserListCommand(sqlSession);
//		command.execute(model);
//		return "employeeModal";
//	}

}
