package com.kb.star.command.room;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.util.RoomDao;

public class UpdateIdeaCommand implements RoomCommand {
	
	SqlSession sqlSession;

	@Autowired
	public UpdateIdeaCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int id = (Integer) map.get("userId");
		int roomId = (Integer) map.get("roomId");
		String title = (String) map.get("myIdea");
		String contents = (String) map.get("ideaDetail");
		int stage = (Integer) map.get("stage");
		
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		dao.isDeleteUpdate(id,roomId);
		dao.submitIdea(id,roomId,title,contents);

		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);
	}

}
