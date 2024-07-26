package com.kb.star.command.firstMeeting;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public class SubmitReplyAnswerCommand implements FirstMeetingCommand {

	private SqlSession sqlSession;

	public SubmitReplyAnswerCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();

		// 콘솔에 전달받은 payload 출력
		Integer userId = (Integer) map.get("userId");
		Integer ideaId = Integer.parseInt((String) map.get("ideaId"));
		Integer roomId = Integer.parseInt((String) map.get("roomId"));
		Integer replyStep = Integer.parseInt((String) map.get("replyStep"));
		String replyContent = (String) map.get("replyContent");

		// 콘솔에 각 변수의 값 출력
		System.out.println("User ID: " + userId);
		System.out.println("Idea ID: " + ideaId);
		System.out.println("Room ID: " + roomId);
		System.out.println("Reply Content: " + replyContent);
		System.out.println("Reply Step: " + replyStep);

		Map<String, Object> params = new HashMap<>();
		params.put("ideaId", ideaId);
		params.put("roomId", roomId);
		params.put("userId", userId);
		params.put("replyContent", replyContent);
		params.put("replyStep", replyStep);

		// 콘솔에 params 출력
		System.out.println("Params for answer: " + params);

		try {
			sqlSession.insert("com.kb.star.util.IdeaDao.insertIdeaAnswerReply", params);
			System.out.println("Reply inserted successfully");
			model.addAttribute("result", "success");
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("Error inserting reply");
			model.addAttribute("result", "failure");
		}
	}
}
