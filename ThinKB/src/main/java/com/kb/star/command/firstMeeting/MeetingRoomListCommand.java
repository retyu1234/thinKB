package com.kb.star.command.firstMeeting;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.Teams;
import com.kb.star.util.UserDao;

public class MeetingRoomListCommand implements FirstMeetingCommand {
	SqlSession sqlSession;
	
	public MeetingRoomListCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int id = (Integer) map.get("id");
		
		//진행중인 회의방 영역
		UserDao dao = sqlSession.getMapper(UserDao.class);
		List<MeetingRooms> dto = dao.myAllMeetingRoom(id); //종료안된것중에 젤 최근꺼 세개
		model.addAttribute("roomList", dto);
		
		String department = dao.userDepartment(id);
		List<Teams> teamDto = dao.myDepartmentTeams(department);
		model.addAttribute("teamInfo", teamDto);

	}

}