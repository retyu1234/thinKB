package com.kb.star.command.room;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.util.RoomDao;

public class UpdateStageThreeCommand implements RoomCommand {

	SqlSession sqlSession;

	@Autowired
	public UpdateStageThreeCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int roomId = Integer.parseInt((String) request.getParameter("roomId"));
//		int stage = Integer.parseInt((String) request.getParameter("stage"));
		int firstIdeaId = Integer.parseInt((String) request.getParameter("firstIdeaId"));
		int secondIdeaId = Integer.parseInt((String) request.getParameter("secondIdeaId"));
		String timer_hours = request.getParameter("timer_hours");
		String timer_minutes = request.getParameter("timer_minutes");
		String timer_seconds = request.getParameter("timer_seconds");

		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		// 현재 시간 구하고, 타이머 시간 구하기
		int hour = 0;
		int min = 0;
		int sec = 0;
		if (timer_hours != null && !timer_hours.isEmpty()) {
			hour = Integer.parseInt(timer_hours);
		}
		if (timer_minutes != null && !timer_minutes.isEmpty()) {
			min = Integer.parseInt(timer_minutes);
		}
		if (timer_seconds != null && !timer_seconds.isEmpty()) {
			sec = Integer.parseInt(timer_seconds);
		}
		LocalDateTime currentTime = LocalDateTime.now();
		LocalDateTime endTime = currentTime.plusHours(hour).plusMinutes(min).plusSeconds(sec);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		String formattedTime = endTime.format(formatter); // 이 시간으로 업데이트 하면 됨
		System.out.println("타이머 저장될 시간? " + formattedTime);
		
		// MeetingRooms 에서 stage +1 0
		dao.updateStage(roomId); 
		
		// Ideas 에서 선택된 두개 아이디어만 StageID 1 -> 3으로 변경 0
		dao.updateIdeaStage3(firstIdeaId);
		dao.updateIdeaStage3(secondIdeaId);
		System.out.println("firstIdeaId : "+firstIdeaId);
		
		// MeetingRoomMembers에서 선택된 두개 아이디어 제공자의 ContributionCnt +1 하고 Role은 yesPick으로 변경
		int userId1 = dao.pickedIdeaUser(firstIdeaId, roomId);
		System.out.println("userId1 : "+userId1);
		int userId2 = dao.pickedIdeaUser(secondIdeaId, roomId);
		dao.updateYesPickNContribution(roomId, userId1);
		dao.updateYesPickNContribution(roomId, userId2);
		
		// Timer 시간 아이디어 두개 새로 insert 해주기
		dao.insertNewTimerForIdea(roomId,firstIdeaId,formattedTime);
		dao.insertNewTimerForIdea(roomId,secondIdeaId,formattedTime);
		
		
		// StageParticipation에서 StageID 3 인거 새로 생성해서 Status 0으로 일괄 넣기
		List<Integer> users = dao.RoomForUserList(roomId);
		for(Integer list : users) {
			dao.insertForwardStage3(firstIdeaId, list, roomId);
		}
		for(Integer list : users) {
			dao.insertForwardStage3(secondIdeaId, list, roomId);
		}

		// roomId, stage값 다시 model에 넣기
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", 3);
	}

}
