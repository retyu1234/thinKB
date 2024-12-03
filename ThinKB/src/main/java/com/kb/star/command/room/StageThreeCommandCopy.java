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

public class StageThreeCommandCopy implements RoomCommand {

	SqlSession sqlSession;

	@Autowired
	public StageThreeCommandCopy(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		System.out.println("stageThreeCommand 호출");
		Map<String, Object> map = model.asMap();
		int roomId = (Integer) map.get("roomId");
		int stage = (Integer) map.get("stage");
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);

		RoomDao dao = sqlSession.getMapper(RoomDao.class);

		// 첫번째 아이디어 id model에 담기 (사이드바에서 이동하는 경우 ideaId 제공으로, ideaId 없을 경우에만 사용하도록 수정
		// 06:10)
		List<Ideas> list = dao.yesPickIdeaList(roomId);
		int ideaId = list.get(0).getIdeaID(); // 선택된것중에 첫번째꺼

		if ((Integer) map.get("ideaId") != null) {
			Integer ideaIdSide = (Integer) map.get("ideaId");
			System.out.println(ideaIdSide);
			ideaId = ideaIdSide;
		}
		model.addAttribute("ideaId", ideaId); // 선택된 것 중 첫 번째 아이디어의 ID 담기

		// idea에서 stageID = 3인(=선택된 아이디어) 조회해서 model에 담기
		List<Ideas> dto = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto);

		// leftSideBar.jsp 출력용
		MeetingRooms meetingRoom = sqlSession.selectOne("com.kb.star.util.RoomDao.roomDetailInfo", roomId);
		model.addAttribute("meetingRoom", meetingRoom);
		/* HttpSession session = (HttpSession) map.get("session"); */
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", (Integer) map.get("id"));
		params.put("roomId", roomId);
		params.put("ideaId", ideaId);

		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByIdeaId", params);
		model.addAttribute("roomMessage", roomMessage);
		// 여기까지 leftSideBar 출력용
	}

}
