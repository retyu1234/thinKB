package com.kb.star.controller;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RequestParam;
import com.kb.star.command.firstMeeting.FirstMeetingCommand;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.command.firstMeeting.FirstMeeting;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class FirstMeetingController {

	private FirstMeetingCommand command;
	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		this.command = new FirstMeeting(sqlSession); // SqlSession을 사용하여 FirstMeetingCommand 구현체를 생성
	}

	// 진행 중인 회의 및 단계
	@RequestMapping("/meetingList")
	public String meetingList(Model model) {
		return "/firstMeeting/meetingList";
	}

	@RequestMapping("/ideaMeeting")
	public String ideaMeeting(@RequestParam("roomTitle") String roomTitle, Model model, HttpSession session) {

		MeetingRooms meetingRoom = sqlSession.selectOne("com.kb.star.util.IdeaDao.selectByTitle", roomTitle);

		/*
		 * String roomTitle = "회의방 1"; MeetingRooms meetingRoom =
		 * sqlSession.selectOne("com.kb.star.util.IdeaDao.selectByTitle", roomTitle);
		 */
		model.addAttribute("meetingRoom", meetingRoom);

		// 아이디어 목록을 RoomID로 조회하여 모델에 추가
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("roomId", meetingRoom.getRoomId());

		session.setAttribute("roomId", meetingRoom.getRoomId());

		List<Ideas> ideas = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeas", params);
		model.addAttribute("ideas", ideas);

		// 세션에서 에러 메시지를 가져와서 모델에 추가
		String errorMessage = (String) session.getAttribute("Message");
		if (errorMessage != null) {
			model.addAttribute("errorMessage", errorMessage);
			session.removeAttribute("Message"); // 에러 메시지를 세션에서 제거
		}

		command.execute(model);
		return "/firstMeeting/ideaMeeting";
	}

	@RequestMapping(value = "/submitVote", method = RequestMethod.POST)
	public String submitVote(@RequestParam("roomTitle") String roomTitle,
			@RequestParam("selectedIdea") String selectedIdea, @RequestParam("roomId") int roomId, HttpSession session,
			Model model) {
		Integer userId = (Integer) session.getAttribute("userId");

		System.out.println("출력");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("ideaId", 0);
		params.put("stageId", 2);
		params.put("roomId", roomId);
		params.put("userId", userId);

		Integer status = sqlSession.selectOne("com.kb.star.util.IdeaDao.checkParticipationStatus", params);

		if (status != null && status == 1) {
			session.setAttribute("Message", "아이디어 투표는 1회만 가능해요.");
			System.out.println(session.getAttribute("Message"));
			try {
				String encodedRoomTitle = URLEncoder.encode(roomTitle, "UTF-8");
				return "redirect:/ideaMeeting?roomTitle=" + encodedRoomTitle; // 에러 메시지와 함께 리다이렉트
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				System.out.println(session.getAttribute("Message"));
				return "redirect:/ideaMeeting?roomTitle=" + roomTitle; // 인코딩 오류 발생 시 기본 리다이렉트
			}
		} else {
			session.setAttribute("Message", "선택한 아이디어 :" + selectedIdea); // 선택한 아이디어 알림
			System.out.println(session.getAttribute("Message"));
			sqlSession.update("com.kb.star.util.IdeaDao.incrementPickNum", selectedIdea);
			sqlSession.update("com.kb.star.util.IdeaDao.updateParticipationStatus", params);
			try {
				String encodedRoomTitle = URLEncoder.encode(roomTitle, "UTF-8");
				return "redirect:/ideaMeeting?roomTitle=" + encodedRoomTitle; // 투표 후 다시 리스트 페이지로 리다이렉트
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
				System.out.println(session.getAttribute("Message"));
				return "redirect:/ideaMeeting?roomTitle=" + roomTitle; // 인코딩 오류 발생 시 기본 리다이렉트
				
			}
		} 
	}
}
