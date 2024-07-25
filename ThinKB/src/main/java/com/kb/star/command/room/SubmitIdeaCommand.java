package com.kb.star.command.room;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.util.RoomDao;

public class SubmitIdeaCommand implements RoomCommand {
	
	SqlSession sqlSession;

	@Autowired
	public SubmitIdeaCommand(SqlSession sqlSession) {
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
		System.out.println("아이디어 정보 오는지 " + title + " / " + contents);
		
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		dao.submitIdea(id,roomId,title,contents);
		dao.updateParticipantStage1(roomId, id);
		
		//기여도 +1 추가
		dao.contributionUpdate(roomId, id);
		
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);
	}

}
