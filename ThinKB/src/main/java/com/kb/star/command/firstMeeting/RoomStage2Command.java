package com.kb.star.command.firstMeeting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import com.kb.star.dto.IdeaReplys;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;

public class RoomStage2Command implements FirstMeetingCommand {

    private SqlSession sqlSession;
    
    @Autowired
    public RoomStage2Command(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        Integer roomId = (Integer) map.get("roomId");
        HttpSession session = (HttpSession) map.get("session");

        MeetingRooms meetingRoom = sqlSession.selectOne("com.kb.star.util.IdeaDao.selectById", roomId);
        model.addAttribute("meetingRoom", meetingRoom);

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("roomId", meetingRoom.getRoomId());

        session.setAttribute("roomId", meetingRoom.getRoomId());

        List<Ideas> ideas = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeas", params);
        model.addAttribute("ideas", ideas);

        List<IdeaReplys> ideaReplys = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeaReplys", params);
        model.addAttribute("ideaReplys", ideaReplys);

        Integer userId = (Integer) session.getAttribute("userId");
        params.put("userId", userId);
        params.put("stageId", 2);
        Integer votedIdeaId = sqlSession.selectOne("com.kb.star.util.IdeaDao.getVotedIdeaId", params);
        model.addAttribute("votedIdeaId", votedIdeaId);
        boolean hasVoted = votedIdeaId != null;
        model.addAttribute("hasVoted", hasVoted);

        String errorMessage = (String) session.getAttribute("Message");
        if (errorMessage != null) {
            model.addAttribute("errorMessage", errorMessage);
            session.removeAttribute("Message");
        }
    }
}
