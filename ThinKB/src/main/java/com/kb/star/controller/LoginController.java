package com.kb.star.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.login.CheckUser;
import com.kb.star.command.login.Login;
import com.kb.star.command.login.LoginCommand;
import com.kb.star.command.user.UserInfoCommand;
import com.kb.star.command.login.Mypage;
import com.kb.star.command.login.ProfileImg;
import com.kb.star.command.login.UpdatePassword;

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

	@RequestMapping("/main") //UserInfoCommand 추가
	public String mainView(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("id", id);
		command = new UserInfoCommand(sqlSession);
		command.execute(model);
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
	public String mypage(HttpSession session,HttpServletRequest request,Model model) {
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("request", request);
		model.addAttribute("userId",userId);
		command=new Mypage(sqlSession);
		command.execute(model);
		return "login/mypage";
	}
	//프로필사진 변경
	@RequestMapping("/updateProfileImg")
	public String updateProfileImg(HttpServletRequest request,Model model) {
		model.addAttribute("request", request);
		command=new ProfileImg(sqlSession);
		command.execute(model);
		return "redirect:/mypage";
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
	//비밀번호 변경화면
	@RequestMapping("/passwordChange")
	public String passwordChange(HttpServletRequest request,Model model) {
		return "login/passwordChange";
	}
	//비밀번호 변경 전 본인확인
	@RequestMapping("/checkUser")
	public String checkUser(HttpServletRequest request,Model model) {
		model.addAttribute("request", request);
		command=new CheckUser(sqlSession);
		command.execute(model);
		Map<String, Object> map = model.asMap();
		String path=(String)map.get("path");
		return path;
	}
	//비밀번호 변경update
	@RequestMapping("/updatePassword")
	public String updatePassword(HttpServletRequest request,Model model) {
		model.addAttribute("request", request);
		command=new UpdatePassword(sqlSession);
		command.execute(model);
		return "redirect:/loginView";
	}
	
}
