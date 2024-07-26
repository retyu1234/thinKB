package com.kb.star.command.room;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.dto.Ideas;
import com.kb.star.util.IdeaOpinionsDao;

public class IdeaOpinions2Command implements RoomCommand {

    SqlSession sqlSession;
    
    @Autowired
    public IdeaOpinions2Command(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
    	
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int roomId = Integer.parseInt(map.get("roomId").toString());
        int ideaId = Integer.parseInt(map.get("ideaId").toString());
        // int stage = Integer.parseInt((String) request.getParameter("stage"));
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        // model.addAttribute("stage", stage);
       
        String currentTab = map.get("currentTab").toString();

        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        model.addAttribute("userId", userId);
        
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        
	    // 타이머 종료 시간 
        String endTime = ideaOpinionsDao.getEndTime(roomId, ideaId);
        model.addAttribute("timer", endTime);
        
        // 방장 ID 가져오기
        int roomManagerId = ideaOpinionsDao.getRoomManagerId(roomId);
        model.addAttribute("roomManagerId", roomManagerId);
        
		//기여도 +1 추가
        // RoomDao roomDao = sqlSession.getMapper(RoomDao.class);
        // roomDao.updateContribution(roomId, ideaId, userId);

	    
        // 방 제목
        Ideas idea = ideaOpinionsDao.getIdeaTitleById(ideaId);
        model.addAttribute("ideaTitle", idea.getTitle());

        // 탭별로 이전 의견을 가져오는 로직
        List<IdeaOpinionsDto> previousSmartOpinions = ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, "Smart");
        List<IdeaOpinionsDto> previousPositiveOpinions = ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, "Positive");
        List<IdeaOpinionsDto> previousWorryOpinions = ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, "Worry");
        List<IdeaOpinionsDto> previousStrictOpinions = ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, "Strict");

        // 현재 탭에 따라 현재 의견을 가져오는 로직
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
        
        List<IdeaOpinionsDto> currentOpinions = ideaOpinionsDao.getCurrentOpinionsByHatColor(ideaId, hatColor);
        
        // 사용자가 특정 의견에 좋아요를 눌렀는지 확인하여 설정
        for (IdeaOpinionsDto opinion : currentOpinions) {
            opinion.setLikedByCurrentUser(ideaOpinionsDao.checkUserLikedOpinion(userId, opinion.getOpinionID()));
        }


        model.addAttribute("previousSmartOpinions", previousSmartOpinions);
        model.addAttribute("previousPositiveOpinions", previousPositiveOpinions);
        model.addAttribute("previousWorryOpinions", previousWorryOpinions);
        model.addAttribute("previousStrictOpinions", previousStrictOpinions);
        
        model.addAttribute("currentOpinions", currentOpinions);
        model.addAttribute("previousOpinions", ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, hatColor));
    }
}


