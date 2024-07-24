package com.kb.star.controller;



import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kb.star.command.report.ReportView;
import com.kb.star.command.room.AfterVoteCommand;
import com.kb.star.command.room.ManagerIdeaListCommand;
import com.kb.star.command.room.ResetCommand;
import com.kb.star.command.room.RoomCommand;
import com.kb.star.command.room.StageOneCommand;
import com.kb.star.command.room.SubmitIdeaCommand;
import com.kb.star.command.room.TimerTestCommand;
import com.kb.star.command.room.UpdateIdeaCommand;
import com.kb.star.command.room.UpdateStageThreeCommand;
import com.kb.star.command.room.UpdateStageTwoCommand;
import com.kb.star.command.room.UserListCommand;
import com.kb.star.command.room.makeRoomCommand;

@Controller
public class IdeaRoomController {

	RoomCommand command = null;
	public SqlSession sqlSession;

	@Autowired
	public IdeaRoomController(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 메인에서 회의방 생성버튼 눌렀을때, 동일 부서직원 목록 조회, 저장해서 view로 이동
	@RequestMapping("/newIdeaRoom")
	public String newIdeaRoom(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("userName");
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("name", name);
		model.addAttribute("id", id);
		command = new UserListCommand(sqlSession);
		command.execute(model);
		return "ideaRoom/newRoom";
	}

	@RequestMapping("/makeRoom")
	public String makeRoom(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new makeRoomCommand(sqlSession);
		command.execute(model);
		return "redirect:/meetingList";
	}

	// 회의방 stage단계별로 화면이동 다르게
	@RequestMapping("/roomDetail")
	public String roomDetail(HttpServletRequest request, @RequestParam("roomId") int roomId,
			@RequestParam("stage") int stage, Model model) {
		HttpSession session = request.getSession();
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("id", id);
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);

		switch (stage) {
		case 1:
			command = new StageOneCommand(sqlSession);
			command.execute(model);
//				Map<String, Object> map = model.asMap();
//				Boolean result = (Boolean)map.get("result");
//				if(result!=null && !result) { 
//					//1단계의 status가 0이면 아이디어 등록화면으로 이동
			return "firstMeeting/roomStage1";
//				} else {
//					//1단계의 status가 1이면 아이디어 기다리라고 나옴
//					return "redirect:main";
//				}
		case 2:
//			model.addAttribute("request", request);
//		    command = new StageTwoCommand(sqlSession);
//		    command.execute(model);
//
//		    return "firstMeeting/ideaMeeting";
			return "redirect:/roomStage2?roomId=" + roomId;
		case 7:
			command = new ReportView(sqlSession);
			command.execute(model);
			return "report/roomStage7";
		default:
			return "main";
		}
	}

	// 아이디어 초안 저장
	@RequestMapping("/submitIdea")
	public String submitIdea(HttpServletRequest request, @RequestParam("roomId") int roomId,
			@RequestParam("myIdea") String myIdea, @RequestParam("ideaDetail") String ideaDetail, 
			@RequestParam("stage") int stage, Model model) {
		HttpSession session = request.getSession();
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		model.addAttribute("roomId", roomId);
		model.addAttribute("myIdea", myIdea);
		model.addAttribute("ideaDetail", ideaDetail);
		model.addAttribute("stage", stage);
		command = new SubmitIdeaCommand(sqlSession);
		command.execute(model);
		return "redirect:/roomDetail";
	}
	
	//아이디어 초안 타이머 시간내 수정하기
	@RequestMapping("/updateIdea")
	public String updateIdea(HttpServletRequest request, @RequestParam("roomId") int roomId,
			@RequestParam("myIdea") String myIdea, @RequestParam("ideaDetail") String ideaDetail,
			@RequestParam("stage") int stage, Model model) {
		HttpSession session = request.getSession();
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		model.addAttribute("roomId", roomId);
		model.addAttribute("myIdea", myIdea);
		model.addAttribute("ideaDetail", ideaDetail);
		model.addAttribute("stage", stage);
		command = new UpdateIdeaCommand(sqlSession);
		command.execute(model);
		return "redirect:/roomDetail";
	}
	
	//방장 메뉴
	@RequestMapping("/managerMenu")
	public String managerMenu(HttpServletRequest request, Model model) {
		return "firstMeeting/managerMenu";
	}
	
	//타이머끝났을때 방장이 투표/반려 선택하는 화면
	@RequestMapping("/stage1Clear")
	public String stage1Clear(HttpServletRequest request, Model model) {
		int roomId = Integer.parseInt((String) request.getParameter("roomId"));
		int stage = Integer.parseInt((String) request.getParameter("stage"));
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);
		
		command = new ManagerIdeaListCommand(sqlSession);
		command.execute(model);
		
		return "firstMeeting/stage1Clear";
	}
	
	//초안에 대한 투표진행화면으로 이동
	@RequestMapping("/goStage2")
	public String goStage2(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);	
		command = new UpdateStageTwoCommand(sqlSession);
		command.execute(model);
		
		return "redirect:main";
	}
	
	//리셋버튼 눌렀을때
	@RequestMapping("/goReset")
	public String goReset(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);	
		command = new ResetCommand(sqlSession);
		command.execute(model);

	    return "redirect:meetingList";
	}
	
	// 타이머 테스용입니다!
	@RequestMapping("/timer")
	public String timer(@RequestParam("roomId") int roomId, Model model, HttpServletRequest request) {
		model.addAttribute("roomId", roomId);
		command = new TimerTestCommand(sqlSession);
		command.execute(model);
		return "TimerTest";
	}
	
	//
	@RequestMapping("/stage2Clear")
	public String stage2Clear(HttpServletRequest request, Model model) {
		int roomId = Integer.parseInt((String) request.getParameter("roomId"));
		int stage = Integer.parseInt((String) request.getParameter("stage"));
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);
		
		command = new AfterVoteCommand(sqlSession);
		command.execute(model);
		
		return "firstMeeting/stage2Clear";
	}
	
	@RequestMapping("/goStage3")
	public String goStage3(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);	
		command = new UpdateStageThreeCommand(sqlSession);
		command.execute(model);
		
		return "redirect:main";
	}
	

	/*
	 * @RequestMapping("/saveAiLog") public Map<String, String>
	 * saveAiLog(@RequestParam("myIdea") String myIdea, HttpServletRequest request,
	 * Model model) { HttpSession session = request.getSession(); int id = (Integer)
	 * session.getAttribute("userId"); model.addAttribute("id", id);
	 * model.addAttribute("myIdea", myIdea); command = new
	 * insertAiLogCommand(sqlSession); command.execute(model);
	 * 
	 * 
	 * if (result) { response.put("status", "success"); response.put("message",
	 * "AI 로그가 성공적으로 저장되었습니다."); } else { response.put("status", "error");
	 * response.put("message", "AI 로그 저장에 실패했습니다."); } } catch (Exception e) {
	 * response.put("status", "error"); response.put("message",
	 * "AI 로그 저장 중 오류가 발생했습니다: " + e.getMessage()); }
	 */

}