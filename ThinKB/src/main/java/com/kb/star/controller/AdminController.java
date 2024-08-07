package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.command.admin.AdminMainCommand;
import com.kb.star.command.user.DeleteEmployee;
import com.kb.star.command.user.DepartmentTeam;
import com.kb.star.command.user.InsertUser;

@Controller
public class AdminController {

	AddCommand command = null;

	@Autowired
	private SqlSession sqlSession;

	// 관리자메인
	@RequestMapping("/adminMain")
	public String adminMain(HttpServletRequest request, Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		
		AdminMainCommand adminMainCommand = new AdminMainCommand(sqlSession);
		adminMainCommand.execute(model);
		
		return "adminMain";
	}
	
	// 회원 관리 
	// 사용자 목록
	@RequestMapping("/userList")
	public String userList(HttpServletRequest request, Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		
		AdminMainCommand adminMainCommand = new AdminMainCommand(sqlSession);
		adminMainCommand.execute(model);
		
		return "/admin/userList";
	}
//	@RequestMapping("/userAdminView")
//	public String userAdminView(HttpSession session,HttpServletRequest request,Model model) {
//		int userId = (Integer) session.getAttribute("userId");
//		model.addAttribute("request",request);
//		model.addAttribute("userId",userId);
//		command = new UserListAdmin(sqlSession);
//		command.execute(model);
//		return "admin/userAdmin";
//	}
	
//	// 사용자 추가
//	@RequestMapping("/addUserView")
//	public String addUser(HttpServletRequest request,Model model) {
//		model.addAttribute("request",request);
//		command = new DepartmentTeam(sqlSession);
//		command.execute(model);
//		return "admin/addUser";
//	}
//	@RequestMapping("/insertUser")
//	public String insertUser(HttpServletRequest request,Model model) {
//		model.addAttribute("request",request);
//		command = new InsertUser(sqlSession);
//		command.execute(model);
//		return "redirect:/userList";
//	}
//	
//	//회원삭제
//	@RequestMapping("/deleteEmployee")
//	public String deleteEmployee(HttpServletRequest request,Model model) {
//		model.addAttribute("request",request);
//		command = new DeleteEmployee(sqlSession);
//		command.execute(model);
//		return "redirect:/userList";
//	}

}
