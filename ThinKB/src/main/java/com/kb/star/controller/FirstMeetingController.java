package com.kb.star.controller;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kb.star.command.firstMeeting.FirstMeeting;
import com.kb.star.command.firstMeeting.FirstMeetingCommand;
import com.kb.star.command.firstMeeting.MeetingRoomListCommand;
import com.kb.star.command.firstMeeting.RoomStage2Command;
import com.kb.star.command.firstMeeting.RoomStage2VoteCommand;
import com.kb.star.command.firstMeeting.SubmitReplyAnswerCommand;
import com.kb.star.command.firstMeeting.SubmitReplyCommand;
import com.kb.star.command.firstMeeting.UpdateIsDeleteCommand;
import com.kb.star.command.room.StageTwoCommand;
import com.kb.star.dto.IdeaReplys;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;

@Controller
public class FirstMeetingController<Command> {

	private FirstMeetingCommand command;
	private SqlSession sqlSession;

	@Autowired
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
		this.command = new FirstMeeting(sqlSession); // SqlSession을 사용하여 FirstMeetingCommand 구현체를 생성
	}

	// 진행 중인 회의 및 단계 + 희의정보 불러오는거 추가함 + 페이지네이션 추가
	@RequestMapping("/meetingList")
	public String meetingList(HttpServletRequest request, Model model, @RequestParam(defaultValue = "1") int page) {
		HttpSession session = request.getSession();
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("id", id);
		model.addAttribute("page", page);
		command = new MeetingRoomListCommand(sqlSession);
		command.execute(model);
		return "/firstMeeting/meetingList";
	}

	// 아이디어 투표하기
	// selectedIdea : 선택한 아이디어의 설명
	@RequestMapping(value = "/submitVote", method = RequestMethod.POST)
	public String submitVote(@RequestParam("ideaId") int ideaId, @RequestParam("selectedIdea") String selectedIdea,
			@RequestParam("roomId") int roomId, HttpSession session, Model model,
			RedirectAttributes redirectAttributes) {
		Integer userId = (Integer) session.getAttribute("userId");

		model.addAttribute("ideaId", ideaId);
		model.addAttribute("selectedIdea", selectedIdea);
		model.addAttribute("roomId", roomId);
		model.addAttribute("userId", userId);
		model.addAttribute("session", session);

		RoomStage2VoteCommand command = new RoomStage2VoteCommand(sqlSession);
		command.execute(model);

		String redirectUrl = (String) model.asMap().get("redirectUrl");
		String message = (String) model.asMap().get("Message");

		redirectAttributes.addFlashAttribute("Message", message);

		return "redirect:" + redirectUrl;
	}

	// 아이디어에 달린 질문 가져오기
	@RequestMapping(value = "/getIdeaReplies", method = RequestMethod.GET, produces = "application/json; charset=UTF-8")

	@ResponseBody
	public String getIdeaReplies(@RequestParam("ideaId") int ideaId) {
		Map<String, Object> params = new HashMap<>();
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
	public String submitReply(@RequestParam Map<String, String> payload, HttpSession session, Model model) {
		Integer userId = (Integer) session.getAttribute("userId");

		// 콘솔에 전달받은 payload 출력ㄴ
		System.out.println("Received payload: " + payload);

		model.addAttribute("userId", userId);
		model.addAttribute("ideaId", payload.get("ideaId"));
		model.addAttribute("roomId", payload.get("roomId"));
		model.addAttribute("replyContent", payload.get("replyContent"));

		SubmitReplyCommand command = new SubmitReplyCommand(sqlSession);
		command.execute(model);

		return (String) model.asMap().get("result");
	}

	// 질문에 답변 등록하기
	@RequestMapping(value = "/submitReplyAnswer", method = RequestMethod.POST, consumes = "application/x-www-form-urlencoded", produces = "text/plain")
	@ResponseBody
	public String submitReplyAnswer(@RequestParam Map<String, String> payload, HttpSession session, Model model) {
		Integer userId = (Integer) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		model.addAttribute("ideaId", payload.get("ideaId"));
		model.addAttribute("roomId", payload.get("roomId"));
		model.addAttribute("replyStep", payload.get("replyStep"));
		model.addAttribute("replyContent", payload.get("replyContent"));

		SubmitReplyAnswerCommand command = new SubmitReplyAnswerCommand(sqlSession);
		command.execute(model);

		return (String) model.asMap().get("result");
	}
	
	// 댓글 삭제(논리적 삭제: IsDelete를 1로 설정)
	@RequestMapping(value = "/deleteReply", method = RequestMethod.POST, consumes = "application/x-www-form-urlencoded", produces = "text/plain")
	@ResponseBody
	public String deleteReply(@RequestParam Map<String, String> payload, HttpSession session, Model model) {
	    Integer userId = (Integer) session.getAttribute("userId");
	    int ideaReplyId = Integer.parseInt(payload.get("ideaReplyId"));

	    // 모델에 필요한 속성 추가
	    model.addAttribute("userId", userId);
	    model.addAttribute("ideaReplyId", ideaReplyId);

	    // 댓글 논리적 삭제 커맨드 실행
	    UpdateIsDeleteCommand command = new UpdateIsDeleteCommand(sqlSession);
	    command.execute(model);

	    // 결과 반환
	    return (String) model.asMap().get("result");
	}


}
