package com.kb.star.command.room;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.RoomDao;

public class AfterVoteCommand implements RoomCommand {

	SqlSession sqlSession;

	@Autowired
	public AfterVoteCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int roomId = (Integer) map.get("roomId");
		int stage = (Integer) map.get("stage");

		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);

		MeetingRooms meetingRoom = sqlSession.selectOne("com.kb.star.util.RoomDao.roomDetailInfo", roomId);
		model.addAttribute("meetingRoom", meetingRoom);
		System.out.println("회의실 정보: " + meetingRoom);

		RoomDao dao = sqlSession.getMapper(RoomDao.class);

		// PickNum높은 순으로 idea목록 담아오기
		List<Ideas> dto = dao.ideaPickNum(roomId);
		model.addAttribute("list", dto);

		// leftSideBar.jsp 출력용
		// idea에서 stageID = 3인(=선택된 아이디어) 조회해서 model에 담기
		List<Ideas> yesPickList = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", yesPickList);

		
		int userId = (Integer) map.get("userId");
		System.out.println("map.get:" +userId);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("roomId", roomId);
		params.put("ideaId", 0);

		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByIdeaId", params);
		model.addAttribute("roomMessage", roomMessage);
		// 여기까지 leftSideBar 출력용
		
		//rightSideBar
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
