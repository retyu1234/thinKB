package com.kb.star.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.NotiDto;
import com.kb.star.util.NotiDao;

@Controller
public class NotiController {
	
	AddCommand command = null;

	@Autowired
	private SqlSession sqlSession;

	
	// 알림 목록 페이지
	@RequestMapping("/noticeList")
	public String noticeList(HttpServletRequest request, Model model, HttpSession session) {
		System.out.println("NoticeController - noticeList");
		
		Integer userId = (Integer) session.getAttribute("userId"); // 세션에 담긴 userId 가져오기
		
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		model.addAttribute("notifications", notiDao.getAllNoti(userId)); // 알림 목록 데이터 가져오기
		
		// 아이디어 정보를 맵핑하여 추가
        List<Ideas> ideas = new ArrayList<Ideas>();
        for (NotiDto notification : notiDao.getAllNoti(userId)) {
            Ideas idea = notiDao.getIdeaById(notification.getIdeaID());
            ideas.add(idea);
        }
        model.addAttribute("ideas", ideas); // 아이디어 데이터 가져오기(IdeaId,title,roomId)
		
		return "noti/noticeList";
	}
	

	

}
