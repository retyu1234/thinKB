package com.kb.star.command.room;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.util.RoomDao;

public class StageThreeCommand implements RoomCommand {

	SqlSession sqlSession;

	@Autowired
	public StageThreeCommand(SqlSession sqlSession) {
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

		// ideaId를 먼저 확인
		Integer ideaId = (Integer) map.get("ideaId");
		System.out.println(ideaId);
		model.addAttribute("ideaId", ideaId);

		// idea에서 stageID = 3인(=선택된 아이디어) 조회해서 model에 담기
		List<Ideas> dto = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto);
		System.out.println("스테이지3커맨드" + dto);

		// leftSideBar.jsp 출력용
		MeetingRooms meetingRoom = sqlSession.selectOne("com.kb.star.util.RoomDao.roomDetailInfo", roomId);
		model.addAttribute("meetingRoom", meetingRoom);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", (Integer) map.get("id"));
		params.put("roomId", roomId);
		params.put("ideaId", ideaId);

		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByIdeaId", params);
		model.addAttribute("roomMessage", roomMessage);
		System.out.println(roomMessage);
		// 여기까지 leftSideBar 출력용
	}

}
