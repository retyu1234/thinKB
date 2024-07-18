package com.kb.star.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kb.star.command.addFunction.Command;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.util.NotiDao;


@Controller
public class NotiController {
	
	Command command = null;

	@Autowired
	private SqlSession sqlSession;

	
	// 알림 목록 페이지
	@RequestMapping("/noticeList")
	public String noticeList(HttpServletRequest request, Model model, HttpSession session) {
		System.out.println("NoticeController - noticeList");
		
		Integer userId = (Integer) session.getAttribute("userId"); // 세션에 담긴 userId 가져오기
		
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		// model.addAttribute("notifications", notiDao.getAllNoti(userId)); // 알림 목록 데이터 가져오기
		List<NotiDto> notifications = notiDao.getAllNoti(userId); // 알림 목록 데이터 가져오기
		
		// 알림에 아이디어 제목 정보를 추가
	    for (NotiDto notification : notifications) {
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
	    
	    model.addAttribute("notifications", notifications);
	    
//		// 아이디어 정보를 맵핑하여 추가
//        List<Ideas> ideas = new ArrayList<Ideas>();
//        for (NotiDto notification : notiDao.getAllNoti(userId)) {
//            Ideas idea = notiDao.getIdeaById(notification.getIdeaID());
//            ideas.add(idea);
//        }
//        model.addAttribute("ideas", ideas); // 아이디어 데이터 가져오기(IdeaId,title,roomId)
		
		return "noti/noticeList";
	}
	
	// 알림 읽음 상태 업데이트
    @RequestMapping("/updateRead/{notificationId}")
    public String updateRead(@PathVariable("notificationId") int notificationID) {
        NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
        notiDao.updateReadStatus(notificationID);
        
        return "redirect:/noticeList";
    }
	
    // 알림 삭제
    @RequestMapping("/deleteNotification")
    public String deleteNotification(@RequestParam("notificationID") int notificationID) {
        NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
        notiDao.deleteNotification(notificationID);
        
        return "redirect:/noticeList"; // 알림 삭제 후 알림 목록 페이지로 리다이렉트
    }

	

}
