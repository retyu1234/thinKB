package com.kb.star.command.roomManger;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.dto.StageParticipationIdeas;
import com.kb.star.util.RoomDao;

public class NoPartiNoti implements RoomCommand{

	SqlSession sqlSession;
	@Autowired
	public NoPartiNoti(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map = model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		int roomId = Integer.parseInt(request.getParameter("roomId"));
		int stageId = Integer.parseInt(request.getParameter("stageId"));
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		List<StageParticipationIdeas> ideaList=dao.getStatusIdeasTitle(roomId);
		dao.insertNotifiNonParti(roomId, stageId, ideaList);
		model.addAttribute("roomId",roomId);
	}

}
