package com.kb.star.command.roomManger;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.dto.MeetingRoomMembers;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.UserListDto;
import com.kb.star.util.RoomDao;

public class UserManagement implements RoomCommand {

	SqlSession sqlSession;
	@Autowired
	public UserManagement(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map=model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		int departmentId = (Integer)map.get("departmentId");
		int roomId=Integer.parseInt(request.getParameter("roomId"));
		RoomDao dao=sqlSession.getMapper(RoomDao.class);
		List<MeetingRoomMembers> dto = dao.selectCurrentMembers(roomId);
		List<UserListDto> dto1 = dao.selectAvailableEmployees(roomId, departmentId);
		MeetingRooms info = dao.roomDetailInfo(roomId);
		model.addAttribute("meetingRoom", info);
		model.addAttribute("members",dto);
		model.addAttribute("addUser",dto1);
		model.addAttribute("roomId",roomId);
	}
}
