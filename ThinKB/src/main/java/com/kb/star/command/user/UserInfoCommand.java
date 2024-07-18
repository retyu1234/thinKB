package com.kb.star.command.user;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.login.LoginCommand;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.util.NotiDao;
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
		List<MeetingRooms> dto = dao.myMeetingRoom(id); //종료안된것중에 젤 최근꺼 세개
		model.addAttribute("roomList", dto);
		
		// 알림함 영역(최대 5개)
        NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
        List<NotiDto> notifications = notiDao.getAllNoti(id); // 알림 목록 데이터 가져오기
        
        // 알림에 아이디어 제목 정보를 추가
        // 읽지 않은 알림 개수 계산
        int unreadCount = 0;
        for (NotiDto notification : notifications) {
            if (!notification.isRead()) {
                unreadCount++;
            }
            Ideas idea = notiDao.getIdeaById(notification.getIdeaID());
            notification.setIdea(idea);

            // Ideas 테이블의 RoomID로 MeetingRooms 테이블의 RoomTitle을 가져오기
            MeetingRooms meetingRoom = notiDao.getRoomTitleById(idea.getRoomID());
            if (meetingRoom != null) {
                notification.setRoomTitle(meetingRoom.getRoomTitle()); // 아이디어에 RoomTitle 설정
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
        System.out.println("unreadCount : " + unreadCount);
		
		// 추가 필요한 정보있으면 밑에 추가
	}

}
