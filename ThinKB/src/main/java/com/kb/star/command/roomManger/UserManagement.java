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
import com.kb.star.dto.MeetingRoomMembers;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.dto.StageParticipationIdeas;
import com.kb.star.dto.UserListDto;
import com.kb.star.dto.UsersDto;
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
		int userId = (Integer)map.get("userId");
		int roomId=Integer.parseInt(request.getParameter("roomId"));
	    String searchKeyword = request.getParameter("searchKeyword");
	    model.addAttribute("searchKeyword", searchKeyword);
		RoomDao dao=sqlSession.getMapper(RoomDao.class);
	    List<MeetingRoomMembers> members = dao.selectCurrentMembers(roomId, searchKeyword);
	    model.addAttribute("members", members);
		List<UserListDto> dto1 = dao.selectAvailableEmployees(roomId, departmentId);
		MeetingRooms info = dao.roomDetailInfo(roomId);
		List<StageParticipationIdeas> statusList= dao.getStatusIdeasTitle(roomId); 
		model.addAttribute("meetingRoom", info);
		model.addAttribute("addUser",dto1);
		model.addAttribute("roomId",roomId);
		model.addAttribute("statusList",statusList);
		// idea에서 stageID = 3인(=선택된 아이디어) 조회해서 model에 담기
		List<Ideas> dto2 = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto2);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("roomId", roomId);
		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByRoomId", params);
		model.addAttribute("roomMessage", roomMessage);
		List<Integer> userIdList = dao.roomIdFormember(roomId);
		List<UsersDto> userList = new ArrayList<UsersDto>();
		for(int ids : userIdList) {
			UsersDto user = dao.whosMember(ids);
			if(user != null) {
				userList.add(user);
			}
		}
		model.addAttribute("userList", userList);
	}
}
