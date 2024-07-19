package com.kb.star.controller;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.IdeaOpinionsDao;


@Controller
public class IdeaOpinionController {
	
	AddCommand command = null;

	@Autowired
	private SqlSession sqlSession;

	
	 // 아이디어 의견을 가져오는 메서드
    @RequestMapping("/ideaOpinions")
    public String getIdeaOpinions(Model model) {
        // MyBatis 매퍼 인터페이스를 사용하여 DAO 객체 생성
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        // 각 모자 색상에 따른 의견 목록을 모델에 추가
        model.addAttribute("smartOpinions", ideaOpinionsDao.findByHatColor("Smart"));
        model.addAttribute("positiveOpinions", ideaOpinionsDao.findByHatColor("Positive"));
        model.addAttribute("worryOpinions", ideaOpinionsDao.findByHatColor("Worry"));
        model.addAttribute("strictOpinions", ideaOpinionsDao.findByHatColor("Strict"));
        
        // 새로운 의견 작성 폼 객체를 모델에 추가
        model.addAttribute("opinionForm", new IdeaOpinionsDto());
        
        // 첫 번째 미팅 페이지로 이동
        return "/firstMeeting/fourOpnion1";
    }

    // 새로운 의견을 추가하는 메서드
    @RequestMapping("/addOpinion")
    public String addOpinion(@ModelAttribute IdeaOpinionsDto opinionForm, HttpSession session, @RequestParam String currentTab) {
        Integer userId = (Integer) session.getAttribute("userId");
        opinionForm.setUserID(userId);
        
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        ideaOpinionsDao.insertOpinion(opinionForm);
        return "redirect:/ideaOpinions?currentTab=" + currentTab;
    }

    @RequestMapping("/updateReadOpinion/{notificationId}")
    public String updateReadOpinion(@PathVariable("notificationId") int notificationID) {
        // MyBatis 매퍼 인터페이스를 사용하여 DAO 객체 생성
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        // 알림 읽음 상태 업데이트
        ideaOpinionsDao.updateReadStatus(notificationID);
        
        // 공지 사항 목록 페이지로 리디렉션
        return "redirect:/noticeList";
    }
}
	

