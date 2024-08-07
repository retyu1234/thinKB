package com.kb.star.command.roomManger;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.TimersDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.RoomDao;

public class RoomManagement implements RoomCommand {

	SqlSession sqlSession;
	@Autowired
	public RoomManagement(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map=model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		int roomId=Integer.parseInt(request.getParameter("roomId"));
		RoomDao dao=sqlSession.getMapper(RoomDao.class);
		MeetingRooms meetingRoom = dao.selectRoomId(roomId);
		List<TimersDto> dto1 = dao.selectTimersByRoomId(roomId);
		List<Ideas> dto2 = dao.selectIdeasByRoomId(roomId);
		model.addAttribute("meetingRoom",meetingRoom);
		model.addAttribute("timers",dto1);
		model.addAttribute("ideas",dto2);
		model.addAttribute("roomId",roomId);
		List<Integer> userIdList = dao.roomIdFormember(roomId);
		List<UsersDto> userList = new ArrayList<UsersDto>();
		for(int ids : userIdList) {
			UsersDto user = dao.whosMember(ids);
			if(user != null) {
				userList.add(user);
			}
		}
		model.addAttribute("userList", userList);
		String timer = dao.roomTimerInfo(roomId);
		model.addAttribute("timer", timer);
		
	}

}
