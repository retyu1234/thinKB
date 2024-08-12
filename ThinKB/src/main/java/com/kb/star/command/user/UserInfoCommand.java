package com.kb.star.command.user;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.login.LoginCommand;
import com.kb.star.dto.BestDto;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.dto.ReportsDto;
import com.kb.star.dto.TodoDto;
import com.kb.star.util.BestDao;
import com.kb.star.util.NotiDao;
import com.kb.star.util.ReportDao;
import com.kb.star.util.UserDao;

public class UserInfoCommand implements LoginCommand {
	SqlSession sqlSession;

	@Autowired
	public UserInfoCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int id = (Integer) map.get("id");

		// 진행중인 회의방 영역
		UserDao dao = sqlSession.getMapper(UserDao.class);
		List<MeetingRooms> dto = dao.myMeetingRoom(id); // 종료안된것중에 완료전
		model.addAttribute("roomList", dto);
		
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		List<NotiDto> notifications = notiDao.getAllNoti(id); // 알림 목록 데이터 가져오기

		// Todo 리스트 가져오기
		List<TodoDto> todoList = dao.getUserTodoListForToday(id);
		model.addAttribute("todoList", todoList);
		// 알림에 아이디어 제목 정보를 추가
		// 읽지 않은 알림 개수 계산
		int unreadCount = 0;
		for (NotiDto notification : notifications) {
			if (!notification.isRead()) {
				unreadCount++;
			}
			if (notification.getIdeaID() != 0) {
				Ideas idea = notiDao.getIdeaById(notification.getIdeaID());
				notification.setIdea(idea);

				// Ideas 테이블의 RoomID로 MeetingRooms 테이블의 RoomTitle을 가져오기
				MeetingRooms meetingRoom = notiDao.getRoomTitleById(idea.getRoomID());
				if (meetingRoom != null) {
					notification.setRoomTitle(meetingRoom.getRoomTitle()); // 아이디어에 RoomTitle 설정
				}

			} else { // ideaID가 0인 경우
				// Ideas 테이블의 RoomID로 MeetingRooms 테이블의 RoomTitle을 가져오기
				MeetingRooms meetingRoom = notiDao.getRoomTitleById(notification.getRoomId());
				if (meetingRoom != null) {
					notification.setRoomTitle(meetingRoom.getRoomTitle()); // 아이디어에 RoomTitle 설정
				}
			}
		}

		// 알림을 읽지 않은 알림이 위로 오도록 정렬
		Collections.sort(notifications, new Comparator<NotiDto>() {
			@Override
			public int compare(NotiDto n1, NotiDto n2) {
				return Boolean.compare(n1.isRead(), n2.isRead());
			}
		});

		// 최대 5개의 알림만 모델에 추가
		if (notifications.size() > 5) {
			notifications = notifications.subList(0, 5);
		}

		model.addAttribute("notifications", notifications);
		model.addAttribute("unreadCount", unreadCount); // 읽지 않은 알림 개수 추가

		// 내가 쓴 보고서 목록 가져오기
		ReportDao repoDao = sqlSession.getMapper(ReportDao.class);

		List<ReportsDto> repoDto = repoDao.getMyReportList(id);
		model.addAttribute("reportList", repoDto);
		

		// 아이디어 목록을 저장할 맵
		Map<Integer, List<Ideas>> roomIdeasMap = new HashMap<>();
		// 각 회의방에 대한 아이디어 리스트를 맵에 추가
		for (MeetingRooms room : dto) {
			List<Ideas> ideasList = sqlSession.selectList("com.kb.star.util.RoomDao.yesPickIdeaList", room.getRoomId());
			roomIdeasMap.put(room.getRoomId(), ideasList);
		}
		model.addAttribute("roomIdeasMap", roomIdeasMap);
		
		
		// 베스트 
		BestDao bestDao = sqlSession.getMapper(BestDao.class);
		
		// 베스트 직원
		List<BestDto> bestEmployees = bestDao.getBestEmployees();
	    model.addAttribute("bestEmployees", bestEmployees);
	    
	    // 베스트 사용량 팀
	    List<BestDto> bestUsage = bestDao.getBestUsage();
	    model.addAttribute("bestUsage", bestUsage);
		
	}

}
