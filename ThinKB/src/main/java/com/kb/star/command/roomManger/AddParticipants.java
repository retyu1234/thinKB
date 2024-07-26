package com.kb.star.command.roomManger;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.util.RoomDao;

public class AddParticipants implements RoomCommand {

	SqlSession sqlSession;

	@Autowired
	public AddParticipants(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	public void execute(Model model) {
	    Map<String, Object> map = model.asMap();
	    HttpServletRequest request = (HttpServletRequest) map.get("request");
	    int roomId = Integer.parseInt(request.getParameter("roomId"));
	    int stageId = Integer.parseInt(request.getParameter("stageId"));
	    model.addAttribute("roomId", roomId);
	    RoomDao dao = sqlSession.getMapper(RoomDao.class);
	    String[] selectedEmployeesArray = request.getParameterValues("selectedEmployees");
	    List<Integer> topIdeaIds = dao.getTopIdeaIds(roomId);
	    List<Integer> selectedEmployees = new ArrayList<Integer>();
        if (selectedEmployeesArray != null) {
            for (String employeeId : selectedEmployeesArray) {
                selectedEmployees.add(Integer.parseInt(employeeId));
            }
        }
        
        // 각 IdeaID에 대해 선택된 직원 처리
        for (int ideaId : topIdeaIds) {
            for (int userId : selectedEmployees) {
                int count = dao.checkExistingEntry(ideaId, stageId, userId, roomId);
                System.out.println("count"+count);
                if (count > 0) {
                    dao.updateParticipation(ideaId, stageId, userId, roomId);
                } else {
                    dao.insertParticipation(ideaId, stageId, userId, roomId);
                }
            }
        }
        
        // 회의실 멤버 추가
        if (!selectedEmployees.isEmpty()) {
            dao.addMeetingRoomMembers(roomId, selectedEmployees);
        }
	}
}
