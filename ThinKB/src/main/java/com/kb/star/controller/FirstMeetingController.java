package com.kb.star.controller;

import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.kb.star.command.firstMeeting.FirstMeeting;
import org.springframework.web.bind.annotation.ResponseBody;
import com.kb.star.command.firstMeeting.FirstMeetingCommand;
import com.kb.star.command.firstMeeting.MeetingRoomListCommand;
import com.kb.star.dto.IdeaReplys;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;

@Controller
public class FirstMeetingController {

    private FirstMeetingCommand command;
    private SqlSession sqlSession;

    @Autowired
    public void setSqlSession(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
        this.command = new FirstMeeting(sqlSession); // SqlSession을 사용하여 FirstMeetingCommand 구현체를 생성
    }

	// 진행 중인 회의 및 단계 + 희의정보 불러오는거 추가함
	@RequestMapping("/meetingList")
	public String meetingList(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("id", id);
		command = new MeetingRoomListCommand(sqlSession);
		command.execute(model);
		return "/firstMeeting/meetingList";
	}


    // 아이디어 회의 목록 표시 페이지
    @RequestMapping("/roomStage2")
    public String ideaMeeting(@RequestParam("roomId") int roomId, Model model, HttpSession session) {

        MeetingRooms meetingRoom = sqlSession.selectOne("com.kb.star.util.IdeaDao.selectById", roomId);
        model.addAttribute("meetingRoom", meetingRoom);

        // 아이디어 목록을 RoomID로 조회하여 모델에 추가
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("roomId", meetingRoom.getRoomId());

        session.setAttribute("roomId", meetingRoom.getRoomId());

        List<Ideas> ideas = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeas", params);
        model.addAttribute("ideas", ideas);

        List<IdeaReplys> ideaReplys = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeaReplys", params);
        model.addAttribute("ideaReplys", ideaReplys);

        // 투표 상태 확인
        Integer userId = (Integer) session.getAttribute("userId");
        params.put("userId", userId);
        params.put("stageId", 2);
        Integer votedIdeaId = sqlSession.selectOne("com.kb.star.util.IdeaDao.getVotedIdeaId", params);
        model.addAttribute("votedIdeaId", votedIdeaId);
        boolean hasVoted = votedIdeaId != null;
        model.addAttribute("hasVoted", hasVoted);

        // 세션에서 에러 메시지를 가져와서 모델에 추가
        String errorMessage = (String) session.getAttribute("Message");
        if (errorMessage != null) {
            model.addAttribute("errorMessage", errorMessage);
            session.removeAttribute("Message"); // 에러 메시지를 세션에서 제거
        }

        command.execute(model);
        return "/firstMeeting/ideaMeeting";
    }

    // 아이디어 투표 버튼 클릭시 수행 로직
    @RequestMapping(value = "/submitVote", method = RequestMethod.POST)
    public String submitVote(@RequestParam("ideaId") int ideaId, @RequestParam("roomTitle") String roomTitle,
                             @RequestParam("selectedIdea") String selectedIdea, @RequestParam("roomId") int roomId, HttpSession session,
                             Model model) {
        Integer userId = (Integer) session.getAttribute("userId");

        System.out.println("출력");
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("ideaId", ideaId);
        params.put("stageId", 2);
        params.put("roomId", roomId);
        params.put("userId", userId);

        // 현재 사용자가 선택한 기존 아이디어 조회
        Integer previousIdeaId = sqlSession.selectOne("com.kb.star.util.IdeaDao.getVotedIdeaId", params);

        Integer status = sqlSession.selectOne("com.kb.star.util.IdeaDao.checkParticipationStatus", params);

        System.out.println("여기까지");

        if (status != null && status == 1) {
            session.setAttribute("Message", "선택한 아이디어 :" + selectedIdea);
            System.out.println(session.getAttribute("Message"));

            // 기존 아이디어 투표 수 감소
            if (previousIdeaId != null) {
                sqlSession.update("com.kb.star.util.IdeaDao.decrementPickNum", previousIdeaId);
            }
            // 새로운 아이디어 투표 수 증가
            sqlSession.update("com.kb.star.util.IdeaDao.incrementPickNum", selectedIdea);
            sqlSession.update("com.kb.star.util.IdeaDao.updateParticipationStatus", params);

            try {
                String encodedRoomTitle = URLEncoder.encode(roomTitle, "UTF-8");
                return "redirect:/roomStage2?roomTitle=" + encodedRoomTitle; // 에러 메시지와 함께 리다이렉트
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
                System.out.println(session.getAttribute("Message"));
                return "redirect:/roomStage2?roomTitle=" + roomTitle; // 인코딩 오류 발생 시 기본 리다이렉트
            }
        } else {
            session.setAttribute("Message", "선택한 아이디어 :" + selectedIdea); // 선택한 아이디어 알림
            System.out.println(session.getAttribute("Message"));
            sqlSession.update("com.kb.star.util.IdeaDao.incrementPickNum", selectedIdea);
            sqlSession.update("com.kb.star.util.IdeaDao.updateParticipationStatus", params);

            try {
                String encodedRoomTitle = URLEncoder.encode(roomTitle, "UTF-8");
                return "redirect:/roomStage2?roomTitle=" + encodedRoomTitle; // 투표 후 다시 리스트 페이지로 리다이렉트
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
                System.out.println(session.getAttribute("Message"));
                return "redirect:/roomStage2?roomTitle=" + roomTitle; // 인코딩 오류 발생 시 기본 리다이렉트
            }
        }
    }

    // 아이디어에 달린 질문 가져오기
    @RequestMapping(value = "/getIdeaReplies", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")
    @ResponseBody
    public String getIdeaReplies(@RequestParam("ideaId") int ideaId) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("ideaId", ideaId);

        List<IdeaReplys> ideaReplies = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeaReplysByIdeaId",
                params);

        ObjectMapper mapper = new ObjectMapper();
        try {
            return mapper.writeValueAsString(ideaReplies);
        } catch (JsonProcessingException e) {
            e.printStackTrace();
            return "[]";
        }
    }

    // 아이디어에 질문 등록하기
    @RequestMapping(value = "/submitReply", method = RequestMethod.POST, consumes = "application/x-www-form-urlencoded", produces = "text/plain")
    @ResponseBody
    public String submitReply(@RequestParam Map<String, String> payload, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        // 콘솔에 전달받은 payload 출력
        System.out.println("Received payload: " + payload);

        Integer ideaId = Integer.parseInt(payload.get("ideaId"));
        Integer roomId = Integer.parseInt(payload.get("roomId"));
        String replyContent = payload.get("replyContent");

        // 콘솔에 각 변수의 값 출력
        System.out.println("User ID: " + userId);
        System.out.println("Idea ID: " + ideaId);
        System.out.println("Room ID: " + roomId);
        System.out.println("Reply Content: " + replyContent);

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("ideaId", ideaId);
        params.put("roomId", roomId);
        params.put("userId", userId);
        params.put("replyContent", replyContent);
        params.put("replyStep", 0);

        // 콘솔에 params 출력
        System.out.println("Params: " + params);

        try {
            sqlSession.insert("com.kb.star.util.IdeaDao.insertIdeaReply", params);
            System.out.println("Reply inserted successfully");
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error inserting reply");
            return "failure";
        }
    }

    // 질문에 답변 등록하기
    @RequestMapping(value = "/submitReplyAnswer", method = RequestMethod.POST, consumes = "application/x-www-form-urlencoded", produces = "text/plain")
    @ResponseBody
    public String submitReplyAnswer(@RequestParam Map<String, String> payload, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");

        // 콘솔에 전달받은 payload 출력
        System.out.println("Received payload for answer: " + payload);

        Integer ideaId = Integer.parseInt(payload.get("ideaId"));
        Integer roomId = Integer.parseInt(payload.get("roomId"));
        Integer replyStep = Integer.parseInt(payload.get("replyStep"));
        String replyContent = payload.get("replyContent");

        // 콘솔에 각 변수의 값 출력
        System.out.println("User ID: " + userId);
        System.out.println("Idea ID: " + ideaId);
        System.out.println("Room ID: " + roomId);
        System.out.println("Reply Content: " + replyContent);
        System.out.println("Reply Step: " + replyStep);

        Map<String, Object> params = new HashMap<String, Object>();
        params.put("ideaId", ideaId);
        params.put("roomId", roomId);
        params.put("userId", userId);
        params.put("replyContent", replyContent);
        params.put("replyStep", replyStep);

        // 콘솔에 params 출력
        System.out.println("Params for answer: " + params);

        try {
            sqlSession.insert("com.kb.star.util.IdeaDao.insertIdeaAnswerReply", params);
            System.out.println("Reply inserted successfully");
            return "success";
        } catch (Exception e) {
            e.printStackTrace();
            System.out.println("Error inserting reply");
            return "failure";
        }
    }
}

