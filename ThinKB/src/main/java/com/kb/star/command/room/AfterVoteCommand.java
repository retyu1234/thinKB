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
		
		// ideas 테이블에서 각 아이디어의 stage를 1 -> 2 로 올림(이거 투표 진행되면 그떄 하기)
//		dao.stageOnetoTwo(roomId);
		
		// PickNum높은 순으로 idea목록 담아오기
		List<Ideas> dto = dao.ideaPickNum(roomId);
		model.addAttribute("list", dto);
	}

}
