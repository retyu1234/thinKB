package com.kb.star.command.room;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.util.RoomDao;

public class StageThreeCommand implements RoomCommand {
	
	SqlSession sqlSession;

	@Autowired
	public StageThreeCommand(SqlSession sqlSession) {
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
		
		// idea에서 stageID = 3인(=선택된 아이디어) 조회해서 model에 담기
		List<Ideas> dto = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto);
	}

}
