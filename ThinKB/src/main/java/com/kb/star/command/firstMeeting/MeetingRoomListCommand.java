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
		int page = (Integer) map.get("page");
		
		int pageSize = 10;
	    int start = (page - 1) * pageSize;
		
		//진행중인 회의방 영역
		UserDao dao = sqlSession.getMapper(UserDao.class);
//		List<MeetingRooms> dto = dao.myAllMeetingRoom(id); //종료안된것중에 젤 최근꺼 세개
//		model.addAttribute("roomList", dto); //페이지네이션 추가하면서 주석처리함
		
		List<MeetingRooms> dto = dao.myAllMeetingRoomPaginated(id, start, pageSize);
        int totalRooms = dao.countMyAllMeetingRooms(id);
        int totalPages = (int) Math.ceil((double) totalRooms / pageSize);

        model.addAttribute("roomList", dto);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
		
		String department = dao.userDepartment(id);
		List<Teams> teamDto = dao.myDepartmentTeams(department);
		model.addAttribute("teamInfo", teamDto);

	}

}