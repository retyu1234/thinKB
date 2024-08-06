package com.kb.star.controller;

import java.io.IOException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.command.roomManger.AllReadCommand;
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

		Integer userId = (Integer) session.getAttribute("userId"); // 세션에 담긴 userId 가져오기

		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		// model.addAttribute("notifications", notiDao.getAllNoti(userId)); // 알림 목록 데이터
		
		List<NotiDto> notifications = notiDao.getAllNoti(userId); // 알림 목록 데이터 가져오기

		// 알림에 아이디어 제목 정보를 추가
		for (NotiDto notification : notifications) {
			if (notification.getIdeaID() != 0) {  // ideaID가 0이 아닌 경우에만 처리
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

	// 사이드바에서 알림 읽음 상태 업데이트
	@RequestMapping(value = "/updateReadSide", method = RequestMethod.POST)
	public ModelAndView updateReadSide(@RequestParam("notificationId") int notificationID, HttpServletRequest request) {
		System.out.println("여기 호출: " + notificationID);
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		notiDao.updateReadStatus(notificationID);

		// 현재 URL 가져오기
		String referer = request.getHeader("Referer");
		return new ModelAndView("redirect:" + referer);
	}

	// 알림 삭제
	@RequestMapping("/deleteNotification")
	public String deleteNotification(@RequestParam("notificationID") int notificationID) {
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		notiDao.deleteNotification(notificationID);

		return "redirect:/noticeList"; // 알림 삭제 후 알림 목록 페이지로 리다이렉트
	}

	// 실시간 알림
	@RequestMapping(value = "/getUnreadNotifications", produces = MediaType.APPLICATION_JSON_VALUE)
	@ResponseBody
	public void getUnreadNotifications(HttpSession session, HttpServletResponse response) throws Exception {
		Integer userId = (Integer) session.getAttribute("userId");
		Timestamp loginTime = (Timestamp) session.getAttribute("loginTime");
		if (userId == null || loginTime == null) {
			response.setContentType("application/json;charset=UTF-8");
			response.getWriter().write("[]");
			return;
		}

		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		List<NotiDto> notifications = notiDao.getUnreadNotificationsSinceLogin(userId, loginTime);

		// 각 알림에 대해 아이디어 정보와 회의방 제목 설정
		for (NotiDto notification : notifications) {
			Ideas idea = notiDao.getIdeaById(notification.getIdeaID());
			notification.setIdea(idea);

			if (idea != null) {
				MeetingRooms meetingRoom = notiDao.getRoomTitleById(idea.getRoomID());
				if (meetingRoom != null) {
					notification.setRoomTitle(meetingRoom.getRoomTitle());
				}
			}
		}

		ObjectMapper mapper = new ObjectMapper();
		String jsonResponse = mapper.writeValueAsString(notifications);

		response.setContentType("application/json;charset=UTF-8");
		response.getWriter().write(jsonResponse);
	}

	// 실시간 알림 데이터 받기
	@RequestMapping("/getInitialNotifications")
	@ResponseBody
	public List<NotiDto> getInitialNotifications(HttpSession session) {
		List<NotiDto> notifications = (List<NotiDto>) session.getAttribute("notifications");
		if (notifications == null) {
			notifications = new ArrayList();
		}
		return notifications;
	}

	// 실시간 알림 세션 담기
	@RequestMapping("/updateNotificationSession")
	@ResponseBody
	public void updateNotificationSession(@RequestParam("notifications") String notificationsJson, HttpSession session)
			throws IOException {
		ObjectMapper mapper = new ObjectMapper();
		List<NotiDto> notifications = mapper.readValue(notificationsJson, new TypeReference<List<NotiDto>>() {
		});
		session.setAttribute("notifications", notifications);
	}

	@RequestMapping("/notiTest")
	public String notiTest(HttpSession session, Model model) {
		return "notiTest";
	}

	// 알림 모두 읽음기능
	@RequestMapping("/allRead")
	public String allRead(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		model.addAttribute("request", request);
		command = new AllReadCommand(sqlSession);
		command.execute(model);

		int updatedRows = (int) model.asMap().get("updatedRows");
		if (updatedRows > 0) {
			redirectAttributes.addFlashAttribute("message", updatedRows + "개의 알림을 읽음 상태로 변경했어요.");
		} else {
			redirectAttributes.addFlashAttribute("message", "읽지않은 알림이 없습니다.");
		}

		return "redirect:/noticeList";
	}

	// 실시간 알림 전체읽음
	@RequestMapping(value = "/readAllNotifications", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> readAllNotifications(HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		Map<String, Boolean> response = new HashMap<>();
		if (userId != null) {
			NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
			notiDao.allReadNotification(userId);
			response.put("success", true);
		} else {
			response.put("success", false);
		}
		return response;
	}

	// 실시간 알림 개별알림리스트 읽음
	@RequestMapping(value = "/readNotification", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Boolean> readNotification(@RequestParam("notificationId") int notificationId) {
		Map<String, Boolean> response = new HashMap<>();
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		notiDao.readNotification(notificationId);
		response.put("success", true);
		return response;
	}

}
