package com.kb.star.command.room;

import java.sql.Timestamp;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.dto.MeetingRooms;
import com.kb.star.util.RoomDao;

public class StageOneCommand implements RoomCommand {
	
	SqlSession sqlSession;

	public StageOneCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int roomId = (Integer) map.get("roomId");
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		MeetingRooms info = dao.roomDetailInfo(roomId);
		model.addAttribute("info", info);
		
		String timer = dao.roomTimerInfo(roomId);
		model.addAttribute("timer", timer);
		
		// 아이디어 참여여부에 따라 페이지 분기를 위한 로직 false=아이디어 안냄/ true=아이디어 냄
		int id = (Integer) map.get("id");
		boolean result = dao.isParticipantsStage1(roomId, id);
		model.addAttribute("result", result);
	}

}
