package com.kb.star.command.roomManger;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Enumeration;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.util.RoomDao;

public class UpdateRoomInfo implements RoomCommand {

	SqlSession sqlSession;

	@Autowired
	public UpdateRoomInfo(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int roomId = Integer.parseInt(request.getParameter("roomId"));
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String endDate = request.getParameter("endDate");
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		dao.updateRoomInfo(title, content, endDate, roomId);
		model.addAttribute("roomId",roomId);
		MeetingRooms info = dao.roomDetailInfo(roomId);
		model.addAttribute("meetingRoom", info);
		Enumeration<String> parameterNames = request.getParameterNames();
		while (parameterNames.hasMoreElements()) {
		    String paramName = parameterNames.nextElement();
		    
		    // ideaId 관련 파라미터 찾기
		    if (paramName.startsWith("ideaId_")) {
		        String ideaIdStr = request.getParameter(paramName);
		        int ideaId = Integer.parseInt(ideaIdStr);
		        
		        // 시간 파라미터 추출
		        String hoursStr = request.getParameter("timer_hours_" + ideaId);
		        String minutesStr = request.getParameter("timer_minutes_" + ideaId);
		        String secondsStr = request.getParameter("timer_seconds_" + ideaId);
		        String endTimeStr = request.getParameter("currentEndTime_" + ideaId);
		        
		        // 기본값 설정
		        int hours = hoursStr != null && !hoursStr.isEmpty() ? Integer.parseInt(hoursStr) : 0;
		        int minutes = minutesStr != null && !minutesStr.isEmpty() ? Integer.parseInt(minutesStr) : 0;
		        int seconds = secondsStr != null && !secondsStr.isEmpty() ? Integer.parseInt(secondsStr) : 0;
		        
		        // 현재 종료 시간 가져오기
		        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
		        LocalDateTime beforeEndTime = LocalDateTime.parse(endTimeStr, formatter);
		        
		        // 종료 시간 계산
		        LocalDateTime endTime = beforeEndTime.plusHours(hours)
		                                             .plusMinutes(minutes)
		                                             .plusSeconds(seconds);
		        
		        // 종료 시간 포맷팅
		        String formattedTime = endTime.format(formatter);
		        
		        // 종료 시간 출력
		        System.out.println("아이디어 ID: " + ideaId + " 타이머 저장될 시간? " + formattedTime);

		        // 타이머 테이블에 신규 타이머 생성
		        dao.roomMangeTimerUpdate(roomId, formattedTime, ideaIdStr);
		    }
		}


	}

}
