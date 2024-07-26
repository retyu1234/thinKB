package com.kb.star.command.firstMeeting;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;

public class SubmitReplyCommand implements RoomCommand {

    private SqlSession sqlSession;

    public SubmitReplyCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        Integer userId = (Integer) map.get("userId");
        Integer ideaId = Integer.parseInt((String) map.get("ideaId"));
        Integer roomId = Integer.parseInt((String) map.get("roomId"));
        String replyContent = (String) map.get("replyContent");

        System.out.println("Received parameters: ");
        System.out.println("User ID: " + userId);
        System.out.println("Idea ID: " + ideaId);
        System.out.println("Room ID: " + roomId);
        System.out.println("Reply Content: " + replyContent);

        Map<String, Object> params = new HashMap<>();
        params.put("ideaId", ideaId);
        params.put("roomId", roomId);
        params.put("userId", userId);
        params.put("replyContent", replyContent);
        params.put("replyStep", 0);

        System.out.println("Params: " + params);

        try {
            sqlSession.insert("com.kb.star.util.IdeaDao.insertIdeaReply", params);
            System.out.println("Reply inserted successfully");
            model.addAttribute("result", "success");
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error inserting reply");
            model.addAttribute("result", "failure");
        }
    }
}
