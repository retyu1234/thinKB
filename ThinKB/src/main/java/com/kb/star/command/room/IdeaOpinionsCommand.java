package com.kb.star.command.room;

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

public class IdeaOpinionsCommand implements RoomCommand {

    SqlSession sqlSession;

    @Autowired
    public IdeaOpinionsCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
    	
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int roomId = Integer.parseInt(map.get("roomId").toString());
        int ideaId = Integer.parseInt(map.get("ideaId").toString());

        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        int teamId = (Integer) session.getAttribute("teamId");
        model.addAttribute("userId", userId);
        

        // 방 제목
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        Ideas idea = ideaOpinionsDao.getIdeaTitleById(ideaId);
        
        model.addAttribute("ideaTitle", idea.getTitle());
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        
        String[] hatColors = {"Smart", "Positive", "Worry", "Strict"};
        for (String hatColor : hatColors) {
            model.addAttribute(hatColor.toLowerCase() + "Opinions", ideaOpinionsDao.findByHatColor(ideaId, hatColor));
        }

        // 팀별 인원 수
        int userCount = ideaOpinionsDao.getUserCountByTeamId(teamId);
        // 견해별 작성 가능한 최대 의견 갯수
        int maxComments = (int) Math.ceil((userCount * 2) / 4.0); // 올림 처리
        model.addAttribute("maxComments", maxComments);
        
        for (String hatColor : hatColors) {
            int opinionCount = ideaOpinionsDao.getOpinionCountByHatColorAndIdeaId(ideaId, hatColor);
            model.addAttribute(hatColor.toLowerCase() + "OpinionCount", opinionCount);
        }

        model.addAttribute("opinionForm", new IdeaOpinionsDto());
        model.addAttribute("userOpinions", ideaOpinionsDao.getUserCommentedTabs(userId, ideaId));
        
        
        
//        List<String> userCommentedTabs = ideaOpinionsDao.getUserCommentedTabs(userId, ideaId);
//        model.addAttribute("userCommentedTabs", userCommentedTabs);
//        
//        // 각 사용자별 작성한 댓글 갯수(IdeaId별)
//        // int userOpinionCount = ideaOpinionsDao.getUserOpinionCount(userId, ideaId);
//        // model.addAttribute("userOpinionCount", userOpinionCount);
//
//        for (String hatColor : hatColors) {
//            int opinionCount = ideaOpinionsDao.getOpinionCountByHatColorAndIdeaId(ideaId, hatColor);
//            model.addAttribute(hatColor.toLowerCase() + "OpinionCount", opinionCount);
//            
//        }
//
//        model.addAttribute("opinionForm", new IdeaOpinionsDto());

    }
}
