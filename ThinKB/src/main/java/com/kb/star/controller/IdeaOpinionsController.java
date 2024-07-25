package com.kb.star.controller;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.command.room.IdeaOpinions2Command;
import com.kb.star.command.room.IdeaOpinionsCommand;
import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.util.IdeaOpinionsDao;


@Controller
public class IdeaOpinionsController {
	
	AddCommand command = null;

	@Autowired
	private SqlSession sqlSession;
	
    // ideaOpinionsList.jsp
    // http://localhost:8080/star/ideaOpinionsList?roomId=49&ideaId=31
    
    // 4가지 의견 한 번에 보기 
    @RequestMapping("/ideaOpinionsList")
    public String viewOpinions(@RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId, HttpServletRequest request, Model model) {
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        model.addAttribute("request", request);
        
        IdeaOpinionsCommand IdeaOpinionsCommand = new IdeaOpinionsCommand(sqlSession);
        IdeaOpinionsCommand.execute(model);
        return "/firstMeeting/ideaOpinionsList"; 
    }
    
    
	// ideaOpinions.jsp
	// http://localhost:8080/star/ideaOpinions?roomId=49&ideaId=31&currentTab=tab-smart
	
	// 아이디어 의견을 가져오는 메서드
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
    
    private String getHatColor(String currentTab) {
        switch (currentTab) {
            case "tab-smart": return "Smart";
            case "tab-positive": return "Positive";
            case "tab-worry": return "Worry";
            case "tab-strict": return "Strict";
            default: return "Smart";
        }
    }
    
    // 의견 작성시 추가
    @RequestMapping("/addOpinion")
    public String addOpinion(@ModelAttribute IdeaOpinionsDto opinionForm, HttpSession session, 
                             @RequestParam String currentTab, @RequestParam int roomId, @RequestParam int ideaId, Model model) {
        System.out.println("addOpinion들어옴");
        Integer userId = (Integer) session.getAttribute("userId");
        Integer teamId = (Integer) session.getAttribute("teamId"); 
        opinionForm.setUserID(userId);
        opinionForm.setIdeaID(ideaId);  
        opinionForm.setCreatedAt(new Timestamp(new Date().getTime())); 

        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        String hatColor = getHatColor(currentTab);
        opinionForm.setHatColor(hatColor);

        int userCount = ideaOpinionsDao.getUserCountByTeamId(teamId); // 팀별 인원 수
        int maxComments = (int) Math.ceil((userCount * 2) / 4.0); // 견해별 작성 가능한 최대 의견 수
        int currentOpinionCount = ideaOpinionsDao.getOpinionCountByHatColorAndIdeaId(ideaId, hatColor); // 현재 견해별 의견 수
        // int userOpinionCount = ideaOpinionsDao.getUserOpinionCount(userId, ideaId); // 각 사용자별 등록한 댓글 갯수(아이디어별)

        
        // 사용자가 작성한 댓글 수와 작성한 탭 목록을 가져옴
        List<String> userCommentedTabs = ideaOpinionsDao.getUserCommentedTabs(userId, ideaId);
        if (userCommentedTabs.contains(hatColor)) {
            model.addAttribute("error", "이미 이 탭에 의견을 작성했습니다.");
            return "redirect:/ideaOpinions?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
        }
        
        
        if (currentOpinionCount >= maxComments) {
            model.addAttribute("error", "댓글 작성 제한 인원을 초과하였습니다.");
            return "redirect:/ideaOpinions?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
        }
        
//        if (userOpinionCount < 2 && currentOpinionCount >= maxComments) {
//            model.addAttribute("error", "댓글 작성 제한 인원을 초과하였습니다.");
//            return "redirect:/ideaOpinions?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
//        } else {
//            ideaOpinionsDao.insertOpinion(opinionForm);
//        }

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
    

    // ideaOpinions2.jsp
    // http://localhost:8080/star/ideaOpinions2?roomId=49&ideaId=31&currentTab=tab-smart
    
    // 기존 의견들 불러오기
    @RequestMapping("/ideaOpinions2")
    public String viewIdeaDetails(HttpServletRequest request, Model model,
    							@RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId, @RequestParam("currentTab") String currentTab) {
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        model.addAttribute("currentTab", currentTab);
        model.addAttribute("request", request);

        IdeaOpinions2Command ideaOpinions2Command = new IdeaOpinions2Command(sqlSession);
        ideaOpinions2Command.execute(model);


        return "/firstMeeting/ideaOpinions2";
    }
    
    // 의견 작성시 추가 + 현재 의견들 불러오기
    @RequestMapping("/addOpinion2")
    public String addOpinion2(@ModelAttribute IdeaOpinionsDto opinionForm, HttpSession session, Model model,
                             @RequestParam String currentTab, @RequestParam int roomId, @RequestParam int ideaId) {
        
        Integer userId = (Integer) session.getAttribute("userId");
        opinionForm.setUserID(userId);
        opinionForm.setIdeaID(ideaId); 
        opinionForm.setStep(2);
        opinionForm.setCreatedAt(new Timestamp(new Date().getTime()));  // 작성 시간을 설정합니다.
        
        // currentTab에 따라 HatColor를 설정합니다.
        String hatColor;
        switch (currentTab) {
            case "tab-smart":
                hatColor = "Smart";
                break;
            case "tab-positive":
                hatColor = "Positive";
                break;
            case "tab-worry":
                hatColor = "Worry";
                break;
            case "tab-strict":
                hatColor = "Strict";
                break;
            default:
                hatColor = "Smart";
        }
        opinionForm.setHatColor(hatColor);  // HatColor 값을 설정합니다.

        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        // 사용자가 이미 이 탭에 의견을 작성했는지 확인
        int existingOpinions = ideaOpinionsDao.countUserOpinionsInTab(userId, ideaId, hatColor, 2);
        int existingOpinions2 = ideaOpinionsDao.countUserOpinionsInTab(userId, ideaId, currentTab, 2);
        if (existingOpinions2 > 0) {
            model.addAttribute("alreadyWritten", true);
        }

        
        ideaOpinionsDao.insertOpinion2(opinionForm);
        
        return "redirect:/ideaOpinions2?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
    }
    
    // 의견 삭제(자신이 작성한 의견일 경우)
    @RequestMapping("/deleteOpinion2")
    public String deleteOpinion2(@RequestParam int opinionId, 
                                @RequestParam String currentTab,
                                @RequestParam int roomId,
                                @RequestParam int ideaId) {
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        // 해당 의견에 대한 모든 좋아요 삭제 처리
        ideaOpinionsDao.deleteLike(opinionId);
        
        // 의견 삭제 처리
        ideaOpinionsDao.deleteOpinion(opinionId);
        
        // 현재 탭과 roomId, ideaId를 포함하여 리다이렉트
        return "redirect:/ideaOpinions2?roomId=" + roomId + "&ideaId=" + ideaId + "&currentTab=" + currentTab;
    }
    
    // 좋아요 
    @RequestMapping(value = "/likeOpinion", method = RequestMethod.POST)
    public String likeOpinion(@RequestParam("opinionId") int opinionId, @RequestParam("like") boolean like, @RequestParam("userId") int userId,
                              @RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId, @RequestParam("currentTab") String currentTab, Model model) {

        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);

        // 좋아요 수 증가 또는 감소
        if (like) {
            ideaOpinionsDao.increaseLikeNum(opinionId);  // 좋아요 수 증가
            ideaOpinionsDao.addUserLike(userId, opinionId);  // 좋아요 추가
        } else {
            ideaOpinionsDao.decreaseLikeNum(opinionId);  // 좋아요 수 감소
            ideaOpinionsDao.removeUserLike(userId, opinionId);  // 좋아요 제거
        }

        int updatedLikeNum = ideaOpinionsDao.getLikeNum(opinionId);
        model.addAttribute("updatedLikeNum", updatedLikeNum);

        return "redirect:/ideaOpinions2?roomId=" + roomId + "&ideaId=" + ideaId + "&currentTab=" + currentTab;
    }

    // 사용자가 특정 의견에 좋아요를 눌렀는지 확인하는 메서드
    private boolean checkIfUserLikedOpinion(int userId, int opinionId) {
    	
    	IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        return ideaOpinionsDao.checkUserLikedOpinion(userId, opinionId);
    }

   
}
	

