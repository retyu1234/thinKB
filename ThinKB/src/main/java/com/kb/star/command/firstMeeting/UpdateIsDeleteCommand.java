package com.kb.star.command.firstMeeting;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import java.util.HashMap;
import java.util.Map;

public class UpdateIsDeleteCommand implements FirstMeetingCommand {

	private SqlSession sqlSession;

	public UpdateIsDeleteCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int ideaReplyId = (Integer) map.get("ideaReplyId");
		int userId = (Integer) map.get("userId");

		Map<String, Object> params = new HashMap<>();
		params.put("ideaReplyId", ideaReplyId);
		params.put("userId", userId);

		// 매퍼 실행
		int result = sqlSession.update("com.kb.star.util.IdeaDao.updateIsDeleteById", params);

		// 결과 처리
		if (result > 0) {
			model.addAttribute("result", "success");
		} else {
			model.addAttribute("result", "failure");
		}
	}

}
