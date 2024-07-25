package com.kb.star.controller;

import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.command.roomManger.CheckNoti;
import com.kb.star.command.roomManger.NotiCommand;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.util.NotiDao;


@Controller
public class NotiController {
	
	AddCommand command = null;
	NotiCommand notiCommand;
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
    //실시간 알림
    @RequestMapping(value = "/notifications", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public ResponseEntity<Map<String, Object>> streamNotifications(
            @RequestParam("userId") int userId,
            @RequestParam("lastCheckTime") long lastCheckTime) {
        try {
            Map<String, Object> model = new HashMap<>();
            model.put("userId", userId);
            model.put("lastCheckTime", lastCheckTime);
            
            CheckNoti notiCommand = new CheckNoti(sqlSession);
            notiCommand.execute(model);
            
            Map<String, Object> response = new HashMap<>();
            response.put("notifications", model.get("notifications"));
            return new ResponseEntity<>(response, HttpStatus.OK);
        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("error", "서버 오류: " + e.getMessage());
            return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
        }
    }

    @RequestMapping("/notiTest")
    public String notiTest() {
        return "notiTest";
    }

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Map<String, Object>> handleException(Exception e) {
        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("error", "서버 오류: " + e.getMessage());
        return new ResponseEntity<>(errorResponse, HttpStatus.INTERNAL_SERVER_ERROR);
    }
	

}
