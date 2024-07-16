package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.user.DepartmentTeam;
import com.kb.star.command.user.InsertUser;
import com.kb.star.command.user.UserCommand;
import com.kb.star.command.user.UserListAdmin;
import com.kb.star.dto.UsersDto;

@Controller
public class UserController {

	private UserCommand command;
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/userAdminView")
	public String userAdminView(HttpSession session,HttpServletRequest request,Model model) {
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("request",request);
		model.addAttribute("userId",userId);
		command = new UserListAdmin(sqlSession);
		command.execute(model);
		return "admin/userAdmin";
	}
	@RequestMapping("/addUserView")
	public String addUser(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		command = new DepartmentTeam(sqlSession);
		command.execute(model);
		return "admin/addUser";
	}
	@RequestMapping("/insertUser")
	public String insertUser(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		command = new InsertUser(sqlSession);
		command.execute(model);
		return "redirect:/";
	}
}
