package com.kb.star.command.room;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

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
		for (String user : list) {
			System.out.println(user);
		}
		
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
		System.out.println("타이머 저장될 시간? " + formattedTime);
		
		
		//제일 마지막 회의방번호 조회 -> 타이머 테이블 신규 생성
		int roomNum = dao.roomNumConfirm(id);
		System.out.println("roomNum " + roomNum);
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

		
		/*
		 * model.addAttribute("id", request.getParameter("id"));
		model.addAttribute("title", request.getParameter("title"));
		model.addAttribute("content", request.getParameter("content"));
		model.addAttribute("endDate", request.getParameter("endDate"));
		model.addAttribute("timer_hours", request.getParameter("timer_hours"));
		model.addAttribute("timer_minutes", request.getParameter("timer_minutes"));
		model.addAttribute("timer_seconds", request.getParameter("timer_seconds"));
		model.addAttribute("users", request.getParameter("users"));
		 */

	}

}
