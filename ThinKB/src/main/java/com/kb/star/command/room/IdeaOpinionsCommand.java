package com.kb.star.command.room;

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
        model.addAttribute("userId", userId);
        

        // 방 제목
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        Ideas idea = ideaOpinionsDao.getIdeaTitleById(ideaId);
        model.addAttribute("ideaTitle", idea.getTitle());
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);


        // 각 모자 색상에 따른 의견 목록을 모델에 추가
        model.addAttribute("smartOpinions", ideaOpinionsDao.findByHatColor("Smart"));
        model.addAttribute("positiveOpinions", ideaOpinionsDao.findByHatColor("Positive"));
        model.addAttribute("worryOpinions", ideaOpinionsDao.findByHatColor("Worry"));
        model.addAttribute("strictOpinions", ideaOpinionsDao.findByHatColor("Strict"));

        // 새로운 의견 작성 폼 객체를 모델에 추가
        model.addAttribute("opinionForm", new IdeaOpinionsDto());
    }
}
