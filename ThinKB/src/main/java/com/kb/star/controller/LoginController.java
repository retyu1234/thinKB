package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	//로그인화면
	@RequestMapping("/loginView")
	public String loginView(Model model) {		
		return "login/login";
	}
	//사용자메인화면
	@RequestMapping("/main")
	public String mainView(Model model) {
		return "main";
	}
	//로그인
	@RequestMapping("/login")
	public String login(HttpServletRequest request,Model model) {
		model.addAttribute("request", request);
		command=new Login(sqlSession);
		command.execute(model);
		return "login/login";
	}
	//마이페이지
	@RequestMapping("/mypage")
	public String mypage(HttpServletRequest request,Model model) {

		return "login/mypage";
	}
	//관리자메인
	@RequestMapping("/adminMain")
	public String adminMain(HttpServletRequest request,Model model) {
		
		return "adminMain";
	}
	//로그아웃
	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {

		// 현재 세션 객체를 가져옴
		HttpSession session = request.getSession();
		// 세션 무효화
		session.invalidate();
		return "redirect:/loginView";
	}
	
}