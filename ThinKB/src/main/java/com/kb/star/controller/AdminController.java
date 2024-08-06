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

}
