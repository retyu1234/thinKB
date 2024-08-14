package com.kb.star.command.room;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.MeetingRooms;
import com.kb.star.util.RoomDao;

public class UpdateStageTwoCommand implements RoomCommand {
	SqlSession sqlSession;

	@Autowired
	public UpdateStageTwoCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int roomId = Integer.parseInt((String) request.getParameter("roomId"));
		int stage = Integer.parseInt((String) request.getParameter("stage"));
		String timer_hours = request.getParameter("timer_hours");
		String timer_minutes = request.getParameter("timer_minutes");
		String timer_seconds = request.getParameter("timer_seconds");

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

		RoomDao dao = sqlSession.getMapper(RoomDao.class);

		// 회의방의 Stage를 2로 변경하기
		dao.updateParticipantStage2(roomId);

		// 방번호의 참여자 목록을 구해서 Stage2의 참여여부 전부 0으로 새로 생성
		List<Integer> users = dao.RoomForUserList(roomId);
		for (Integer list : users) {
			dao.insertForwardStage2(list, roomId);
		}

		// 타이머 업데이트
		dao.stageTwoTimerUpdate(roomId, formattedTime);

		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", 2);

		// 알림 보내기 추가
		MeetingRooms roomInfo = dao.roomDetailInfo(roomId);
		String notification = "[" + roomInfo.getRoomTitle() + "] 회의방의 아이디어 초안에 대한 ✅투표가 시작됐어요. 제출된 아이디어를 확인해보고 좋은 아이디어라고 생각되는 곳에 투표해주세요.";

		for (int user : users) {
			dao.makeNotification(user, 0, notification, roomId);
		}
	}

}
