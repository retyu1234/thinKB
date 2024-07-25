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

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int roomId = Integer.parseInt(request.getParameter("roomId"));
		int stageId = Integer.parseInt(request.getParameter("stageId"));
		model.addAttribute("roomId", roomId);
		System.out.println(roomId+"/"+stageId);
		String[] selectedEmployeesArray = request.getParameterValues("selectedEmployees");

		if (selectedEmployeesArray != null && selectedEmployeesArray.length > 0) {
			List<Integer> selectedEmployees = new ArrayList<Integer>();
			for (String employeeId : selectedEmployeesArray) {
				selectedEmployees.add(Integer.parseInt(employeeId));
			}

			// MeetingRoomMemberDao 인스턴스를 가져오는 방법에 따라 이 부분을 수정해야 할 수 있습니다.
			RoomDao dao = sqlSession.getMapper(RoomDao.class);

			// 한 번의 호출로 전체 리스트를 처리
			dao.addMeetingRoomMembers(roomId, selectedEmployees);
			dao.insertStageParticipations(roomId, stageId, selectedEmployees);

		}
	}
}
