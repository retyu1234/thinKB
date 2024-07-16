package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.login.Login;
import com.kb.star.command.login.LoginCommand;

@Controller
public class LoginController {

	private LoginCommand command;
	@Autowired
	private SqlSession sqlSession;
	
	@RequestMapping("/loginView")
	public String loginView(Model model) {		
		return "login/login";
	}
	@RequestMapping("/main")
	public String mainView(Model model) {
		return "main";
	}
	@RequestMapping("/login")
	public String login(HttpServletRequest request,Model model) {
		model.addAttribute("request", request);
		command=new Login(sqlSession);
		command.execute(model);
		return "login/login";
	}
	@RequestMapping("/mypage")
	public String mypage(HttpServletRequest request,Model model) {

		return "login/mypage";
	}
	@RequestMapping("/adminMain")
	public String adminMain(HttpServletRequest request,Model model) {
		
		return "adminMain";
	}
}
