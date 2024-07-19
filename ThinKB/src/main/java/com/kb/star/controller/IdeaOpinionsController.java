package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;
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
import com.kb.star.command.room.IdeaOpinionsCommand;
import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.util.IdeaOpinionsDao;


@Controller
public class IdeaOpinionsController {
	
	AddCommand command = null;

	@Autowired
	private SqlSession sqlSession;
	
	
	// 아이디어 의견을 가져오는 메서드
	// http://localhost:8080/star/ideaOpinions?roomId=49&ideaId=31&currentTab=tab-smart
    @RequestMapping("/ideaOpinions")
    public String getIdeaOpinions(HttpServletRequest request, @RequestParam("roomId") int roomId,
			@RequestParam("ideaId") int ideaId,@RequestParam("currentTab") String currentTab, Model model) {
    	
    	model.addAttribute("request", request);
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        model.addAttribute("currentTab", currentTab);
        
        IdeaOpinionsCommand IdeaOpinionsCommand = new IdeaOpinionsCommand(sqlSession);
        IdeaOpinionsCommand.execute(model);

        return "/firstMeeting/ideaOpinions";
    }

    // 의견 작성시 추가
    @RequestMapping("/addOpinion")
    public String addOpinion(@ModelAttribute IdeaOpinionsDto opinionForm, HttpSession session, 
                             @RequestParam String currentTab, @RequestParam int roomId, @RequestParam int ideaId) {
        
    	Integer userId = (Integer) session.getAttribute("userId");
        opinionForm.setUserID(userId);

        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        ideaOpinionsDao.insertOpinion(opinionForm);
        
        return "redirect:/ideaOpinions?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
    }

    // 의견 삭제(자신이 작성한 의견일 경우)
    @RequestMapping("/deleteOpinion")
    public String deleteOpinion(@RequestParam int opinionId, 
                                @RequestParam String currentTab,
                                @RequestParam int roomId,
                                @RequestParam int ideaId) {
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        // 의견 삭제 처리
        ideaOpinionsDao.deleteOpinion(opinionId);
        
        // 현재 탭과 roomId, ideaId를 포함하여 리다이렉트
        return "redirect:/ideaOpinions?roomId=" + roomId + "&ideaId=" + ideaId + "&currentTab=" + currentTab;
    }
    
    
    // 안쓰는거
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
	

