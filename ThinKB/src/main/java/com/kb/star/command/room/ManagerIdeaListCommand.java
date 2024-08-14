package com.kb.star.command.room;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.NotiDao;
import com.kb.star.util.RoomDao;

public class ManagerIdeaListCommand implements RoomCommand {

	SqlSession sqlSession;

	@Autowired
	public ManagerIdeaListCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int roomId = (Integer) map.get("roomId");
		int stage = (Integer) map.get("stage");
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);

		RoomDao dao = sqlSession.getMapper(RoomDao.class);
//		List<Ideas> dto = dao.ideaList(roomId, stage);
		List<Ideas> dto = dao.ideaListUnreject(roomId, stage); // 리젝트된것 제거
		model.addAttribute("ideaList", dto);

		// 방장 사이드바 사용
		MeetingRooms info = dao.roomDetailInfo(roomId);
		model.addAttribute("meetingRoom", info);

		// 오른쪽 사이드바
		List<Integer> userIdList = dao.roomIdFormember(roomId);
		List<UsersDto> userList = new ArrayList<UsersDto>();
		for (int ids : userIdList) {
			UsersDto user = dao.whosMember(ids);
			if (user != null) {
				userList.add(user);
			}
		}
		model.addAttribute("userList", userList);
		
		String timer = dao.roomTimerInfo(roomId); // 사이드바용 타이머
		model.addAttribute("timer", timer);
		
		//왼쪽 사이드바 알림
		int id = (Integer) map.get("id");
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		List<NotiDto> roomMessage = notiDao.getMessagesByIdeaId(id, roomId, 0);
		model.addAttribute("roomMessage", roomMessage);
		
		//상단 6개 단계를 위한 yesPickList
		List<Ideas> dto1 = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto1);
		
	}

}
