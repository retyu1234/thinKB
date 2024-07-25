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
import com.kb.star.command.room.StageThreeCommand;
import com.kb.star.command.room.SubmitIdeaCommand;
import com.kb.star.command.room.TimerTestCommand;
import com.kb.star.command.room.UpdateIdeaCommand;
import com.kb.star.command.room.UpdateStageThreeCommand;
import com.kb.star.command.room.UpdateStageTwoCommand;
import com.kb.star.command.room.UserListCommand;
import com.kb.star.command.room.makeRoomCommand;
import com.kb.star.command.roomManger.AddParticipants;
import com.kb.star.command.roomManger.RemoveParticipant;
import com.kb.star.command.roomManger.RoomManagement;
import com.kb.star.command.roomManger.UpdateRoomInfo;
import com.kb.star.command.roomManger.UserManagement;

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
			return "firstMeeting/roomStage1";

		case 2:
			return "redirect:/roomStage2?roomId=" + roomId;
			
		case 3:
			command = new StageThreeCommand(sqlSession);
			command.execute(model);
			return "redirect:/ideaOpinionsList";
			
		case 4:
			return "firstMeeting/ideaOpinions2";

		case 5:
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
		
		//방정보 수정
		@RequestMapping("/updateRoomInfo")
		public String updateRoomInfo(HttpServletRequest request,Model model) {
			model.addAttribute("request",request);
			command=new UpdateRoomInfo(sqlSession);
			command.execute(model);
			return "redirect:/roomManagement";
		}
		//참여자관리화면 방장
		@RequestMapping("/userManagement")
		public String userManagement(HttpSession session,HttpServletRequest request,Model model) {
			Integer departmentId = (Integer)session.getAttribute("departmentId");
			model.addAttribute("request",request);
			model.addAttribute("departmentId",departmentId);
			command=new UserManagement(sqlSession);
			command.execute(model);
			return "ideaRoom/userManagement";
		}
		//참여자 추가 방장
		@RequestMapping("/addParticipants")
		public String addParticipants(HttpServletRequest request,Model model) {
			model.addAttribute("request",request);
			command=new AddParticipants(sqlSession);
			command.execute(model);
			return "redirect:/userManagement";
		}
		//참여자 삭제 방장
		@RequestMapping("/removeParticipant")
		public String removeParticipant(HttpServletRequest request,Model model) {
			model.addAttribute("request",request);
			command=new RemoveParticipant(sqlSession);
			command.execute(model);
			return "redirect:/userManagement";
		}
		//참여자 알림발송화면 방장
		@RequestMapping("/sendNotifications")
		public String sendNotifications(HttpSession session,HttpServletRequest request,Model model) {
			Integer departmentId = (Integer)session.getAttribute("departmentId");
			model.addAttribute("request",request);
			model.addAttribute("departmentId",departmentId);
			command=new UserManagement(sqlSession);
			command.execute(model);
			return "ideaRoom/notiSendRoom";
		}
		
		// 타이머 테스용입니다!
		@RequestMapping("/timer")
		public String timer(@RequestParam("roomId") int roomId, Model model, HttpServletRequest request) {
			model.addAttribute("roomId", roomId);
			command = new TimerTestCommand(sqlSession);
			command.execute(model);
			return "TimerTest";
		}
		

	// 방장 메뉴
	@RequestMapping("/managerMenu")
	public String managerMenu(HttpServletRequest request, Model model) {
		return "firstMeeting/managerMenu";
	}

	// 타이머끝났을때 방장이 투표/반려 선택하는 화면
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

	// 초안에 대한 투표진행화면으로 이동
	@RequestMapping("/goStage2")
	public String goStage2(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new UpdateStageTwoCommand(sqlSession);
		command.execute(model);

		return "redirect:/roomDetail";
	}

	// 방관리화면
	@RequestMapping("/roomManagement")
	public String roomManagement(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new RoomManagement(sqlSession);
		command.execute(model);
		return "ideaRoom/roomManagement";
	}

	// 리셋버튼 눌렀을때
	@RequestMapping("/goReset")
	public String goReset(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new ResetCommand(sqlSession);
		command.execute(model);
		return "redirect:meetingList";
	}

	// 처음 투표완료 후 방장이 투표결과 목록 확인
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

	// 아이디어 투표완료, 다음단계(아이디어별 의견수보) 진행
	@RequestMapping("/goStage3")
	public String goStage3(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new UpdateStageThreeCommand(sqlSession);
		command.execute(model);

		return "redirect:/ideaOpinionsList";
	}

}