package com.kb.star.command.room;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.MeetingRooms;
import com.kb.star.util.RoomDao;

public class TimerTestCommand implements RoomCommand {

	SqlSession sqlSession;
	
	@Autowired
	public TimerTestCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int roomId = (Integer) map.get("roomId");
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		String timer = dao.roomTimerInfo(roomId);
		model.addAttribute("timer", timer);
		
		MeetingRooms roomInfo = dao.roomDetailInfo(roomId);
		model.addAttribute("roomInfo", roomInfo);
	}
 
}
