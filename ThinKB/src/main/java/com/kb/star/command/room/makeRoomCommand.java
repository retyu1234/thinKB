package com.kb.star.command.room;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.util.RoomDao;
import com.kb.star.util.UserDao;

public class makeRoomCommand implements RoomCommand {
	
	SqlSession sqlSession;

	@Autowired
	public makeRoomCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String id = request.getParameter("id");
		String departmentId = request.getParameter("departmentId");
		String teamId = request.getParameter("teamId");
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String endDate = request.getParameter("endDate");
		String timer_hours = request.getParameter("timer_hours");
		String timer_minutes = request.getParameter("timer_minutes");
		String timer_seconds = request.getParameter("timer_seconds");
		String users = request.getParameter("users");
		String[] list = users.split(",");
		
		// MeetingRooms 회의방 신규 생성
		UserDao dao = sqlSession.getMapper(UserDao.class);
		dao.insertNewRoom(title, content, departmentId, teamId, id, endDate);
		
		//현재 시간 구하고, 타이머 시간 구하기
		int hour = 0;
		int min = 0;
		int sec = 0;
		if(timer_hours!=null && !timer_hours.isEmpty()) {
			hour = Integer.parseInt(timer_hours);
		}
		if(timer_minutes!=null && !timer_minutes.isEmpty()) {
			min = Integer.parseInt(timer_minutes);
		}
		if(timer_seconds!=null && !timer_seconds.isEmpty()) {
			sec = Integer.parseInt(timer_seconds);
		}
		LocalDateTime currentTime = LocalDateTime.now();
		LocalDateTime endTime = currentTime.plusHours(hour)
										.plusMinutes(min)
										.plusSeconds(sec);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		String formattedTime = endTime.format(formatter);
		
		
		//제일 마지막 회의방번호 조회 -> 타이머 테이블 신규 생성
		int roomNum = dao.roomNumConfirm(id);
		dao.insertNewTimer(roomNum,formattedTime);
		
		//회의방멤버 추가(방장/참여자 따로)
		dao.insertUserIntoRoom(roomNum, id);
		for (String user : list) {
			dao.insertUserIntoRoom(roomNum, user);
		}
		
		//참여여부 0단계(방생성)->모두 참여
		dao.insertThisStage0(id, roomNum);
		for (String user : list) {
			dao.insertThisStage0(user, roomNum);
		}
		
		//참여여부 1단계(초안작성) -> 모두 미참여로 만들어두기
		dao.insertForwardStage1(id, roomNum);
		for (String user : list) {
			dao.insertForwardStage1(user, roomNum);
		}
		
		model.addAttribute("id", id);
		
		//방만들고 알림 보내기 추가
		RoomDao roomDao = sqlSession.getMapper(RoomDao.class);
		
		String notification = "회의방이 새로 만들어졌어요, 🕒"
				+ hour + "시간 " + min + "분 "+ sec + "초안에 [" + title
						+ "]에 대한 아이디어를 제출해주세요!";
		
		roomDao.makeNotification(Integer.parseInt(id), 0, notification, roomNum);
		for (String user : list) {
			int notiId = Integer.parseInt(user);
			roomDao.makeNotification(notiId, 0, notification, roomNum);
		}
	}

}
