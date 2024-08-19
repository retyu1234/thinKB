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
import com.kb.star.dto.NotiDto;
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
		int userId = (Integer)map.get("userId");
		int roomId=Integer.parseInt(request.getParameter("roomId"));
		RoomDao dao=sqlSession.getMapper(RoomDao.class);
		MeetingRooms meetingRoom = dao.selectRoomId(roomId);
		List<TimersDto> dto1 = dao.selectTimersByRoomId(roomId);
		List<Ideas> dto2 = dao.selectIdeasByRoomId(roomId);
		int pickOneId = dao.getIdeaIdPickOne(roomId);
		model.addAttribute("meetingRoom",meetingRoom);
		model.addAttribute("timers",dto1);
		model.addAttribute("ideas",dto2);
		model.addAttribute("roomId",roomId);
		model.addAttribute("ideaId",pickOneId);
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
		// idea에서 stageID = 3인(=선택된 아이디어) 조회해서 model에 담기
		List<Ideas> dto3 = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto3);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("roomId", roomId);
		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByRoomId", params);
		model.addAttribute("roomMessage", roomMessage);
		int totalContributionNum = dao.totalContributionNum(roomId);
		model.addAttribute("totalContributionNum", totalContributionNum);
		
		int myContributionNum = dao.myContributionNum(roomId, userId);
		model.addAttribute("myContributionNum", myContributionNum);
	}

}
