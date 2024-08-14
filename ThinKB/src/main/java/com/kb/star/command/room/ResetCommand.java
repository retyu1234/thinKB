package com.kb.star.command.room;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.RejectLog;
import com.kb.star.util.RoomDao;

public class ResetCommand implements RoomCommand {

	SqlSession sqlSession;

	@Autowired
	public ResetCommand(SqlSession sqlSession) {
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

		//반려사유 값 가져오기
		List<RejectLog> dto = new ArrayList<RejectLog>();
		Map<String, String[]> paramMap = request.getParameterMap();

		for (String key : paramMap.keySet()) {
			if (key.startsWith("rejectLog[") && key.endsWith("].rejectContents")) {
				RejectLog log = new RejectLog();
				String[] values = paramMap.get(key);

				// Extract index from the key
				int startIndex = key.indexOf("[") + 1;
				int endIndex = key.indexOf("]");
				String indexStr = key.substring(startIndex, endIndex);
				int index = Integer.parseInt(indexStr);

				// Set rejectContents
				if (values != null && values.length > 0) {
					log.setRejectContents(values[0]);
				}

				// Set ideaId (which will be used as rejectId in this case)
				String ideaIdKey = "rejectLog[" + index + "].ideaId";
				String[] ideaIdValues = paramMap.get(ideaIdKey);
				if (ideaIdValues != null && ideaIdValues.length > 0) {
					log.setRejectId(Integer.parseInt(ideaIdValues[0]));
				}

				dto.add(log);
			}
		}

		// 반려사유 db에 추가하고, ideas에서 isReject업데이트
		for (RejectLog log : dto) {
			System.out.println("RejectId: " + log.getRejectId() + ", RejectContents: " + log.getRejectContents());
			dao.updateRejectLog(roomId,log.getRejectId(),log.getRejectContents());
			dao.isRejectUpdate(log.getRejectId());
		}
		
		// 타이머를 새로 리셋
		dao.stageTwoTimerUpdate(roomId,formattedTime);
		
		//알림 보내기(방번호로 참여자 list가져와서, 모든 방참여자에게 알림발송)
		List<Integer> list = dao.RoomForUserList(roomId);
		
		MeetingRooms roomInfo = dao.roomDetailInfo(roomId);
		String notification = "[" + roomInfo.getRoomTitle() + "] 회의방에 제출된 아이디어 초안이 반려되었어요. 다른 아이디어를 제출해주세요.";
		for(Integer user : list) {
			List<Ideas> idea = dao.ideaInfo(roomId, user);
			int ideaNum = 0;
			if(idea != null && !idea.isEmpty()) {
				ideaNum = idea.get(0).getIdeaID(); 
			}
			dao.makeNotification(user, ideaNum, notification, roomId);
		}
		

	}

}
