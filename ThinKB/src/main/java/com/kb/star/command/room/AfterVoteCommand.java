package com.kb.star.command.room;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.util.RoomDao;

public class AfterVoteCommand implements RoomCommand {
	
	SqlSession sqlSession;
	
	@Autowired
	public AfterVoteCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int roomId = (Integer) map.get("roomId");
		int stage = (Integer) map.get("stage");
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);
		
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		
		// PickNum높은 순으로 idea목록 담아오기
		List<Ideas> dto = dao.ideaPickNum(roomId);
		model.addAttribute("list", dto);
	}

}
