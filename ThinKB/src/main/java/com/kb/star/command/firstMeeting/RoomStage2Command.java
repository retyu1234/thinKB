package com.kb.star.command.firstMeeting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.dto.IdeaReplys;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.util.RoomDao;

public class RoomStage2Command implements FirstMeetingCommand, RoomCommand {

	private SqlSession sqlSession;

	public RoomStage2Command(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpSession session = (HttpSession) map.get("session");
		int roomId = (Integer) map.get("roomId");
		System.out.println("방번호" + roomId);
		int userId = (Integer) map.get("id");
		System.out.println("사용자아이디" + userId);

		// 아이디어 목록을 RoomID로 조회하여 모델에 추가
		Map<String, Object> params = new HashMap<String, Object>();

		// 아이디어 목록 가져오기
		List<Ideas> ideas = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeas", roomId);
		model.addAttribute("ideas", ideas);

		List<IdeaReplys> ideaReplys = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeaReplys", roomId);
		model.addAttribute("ideaReplys", ideaReplys);

		MeetingRooms meetingRoom = sqlSession.selectOne("com.kb.star.util.RoomDao.roomDetailInfo", roomId);
		model.addAttribute("meetingRoom", meetingRoom);
		// 투표 상태 확인
		params.put("userId", userId);
		params.put("stageId", 2);
		params.put("roomId", roomId);
		
		// leftSideBar.jsp 출력용
		params.put("ideaId", 0);
		/* Map<String, Object> params = new HashMap<String, Object>(); */
		List<Ideas> yesPickList = sqlSession.selectList("com.kb.star.util.RoomDao.yesPickIdeaList", roomId);
		model.addAttribute("yesPickList", yesPickList);

		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByIdeaId", params);
		model.addAttribute("roomMessage", roomMessage);
		//여기까지 leftSideBar 출력용

		Integer votedIdeaId = sqlSession.selectOne("com.kb.star.util.IdeaDao.getVotedIdeaId", params);
		model.addAttribute("votedIdeaId", votedIdeaId);
		boolean hasVoted = votedIdeaId != null;
		model.addAttribute("hasVoted", hasVoted);

		// 타이머 모델에 담기
		String timer = sqlSession.selectOne("com.kb.star.util.RoomDao.roomTimer", params);
		model.addAttribute("timer", timer);

		// 방장 투표인원 확인용
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		int total = dao.totalRoomUsers(roomId);
		model.addAttribute("total", total);

		int voteCnt = dao.voteRoomUsers(roomId);
		model.addAttribute("voteCnt", voteCnt);

	}
}
