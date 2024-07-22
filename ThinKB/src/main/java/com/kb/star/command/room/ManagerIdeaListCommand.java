package com.kb.star.command.room;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.util.RoomDao;

public class ManagerIdeaListCommand implements RoomCommand {
	
	SqlSession sqlSession;

	@Autowired
	public ManagerIdeaListCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int roomId = (Integer) map.get("roomId");
		int stage = (Integer) map.get("stage");
		
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		List<Ideas> dto = dao.ideaList(roomId, stage);
		model.addAttribute("ideaList", dto);

	}

}
