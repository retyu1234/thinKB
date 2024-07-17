package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.addFunction.Command;
import com.kb.star.util.NotiDao;

@Controller
public class NotiController {
	
	Command command = null;

	@Autowired
	private SqlSession sqlSession;

	
	// 알림 목록 페이지로 이동
	@RequestMapping("/noticeList")
	public String noticeList(HttpServletRequest request, Model model) {
		System.out.println("NoticeController - noticeList");
		
		int userId = Integer.parseInt(request.getParameter("userId")); 
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		model.addAttribute("notifications", notiDao.getAllNoti(userId)); // 알림 목록 데이터를 모델에 추가
		
		return "notice/noticeList";
	}
	

	

}
