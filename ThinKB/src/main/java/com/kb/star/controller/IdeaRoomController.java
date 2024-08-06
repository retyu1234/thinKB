package com.kb.star.controller;

import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.Gson;
import com.kb.star.command.ai.AiService;
import com.kb.star.command.ai.AiService2;
import com.kb.star.command.firstMeeting.RoomStage2Command;
import com.kb.star.command.report.ReportView;
import com.kb.star.command.room.AfterVoteCommand;
import com.kb.star.command.room.ManagerIdeaListCommand;
import com.kb.star.command.room.ResetCommand;
import com.kb.star.command.room.RoomCommand;
import com.kb.star.command.room.StageOneCommand;
import com.kb.star.command.room.StageThreeCommand;
import com.kb.star.command.room.SubmitIdeaCommand;
import com.kb.star.command.room.UpdateIdeaCommand;
import com.kb.star.command.room.UpdateStageThreeCommand;
import com.kb.star.command.room.UpdateStageTwoCommand;
import com.kb.star.command.room.UserListCommand;
import com.kb.star.command.room.makeRoomCommand;
import com.kb.star.command.roomManger.AddParticipants;
import com.kb.star.command.roomManger.NoPartiNoti;
import com.kb.star.command.roomManger.RemoveParticipant;
import com.kb.star.command.roomManger.RoomManagement;
import com.kb.star.command.roomManger.SendNotiUser;
import com.kb.star.command.roomManger.UpdateRoomInfo;
import com.kb.star.command.roomManger.UserManagement;
import com.kb.star.dto.AiLogDto;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.util.AiDao;
import com.kb.star.util.RoomDao;

@Controller
public class IdeaRoomController {

	RoomCommand command = null;
	public SqlSession sqlSession;
	@Autowired
	private AiService aiService;
	@Autowired
	private AiService2 aiService2;
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
	// 회의방 설정시 주제상세 ai
		@RequestMapping(value = "/getAiResponse", produces = MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8")
		@ResponseBody
		public String getAiResponse(@RequestParam("userInput") String userInput) {
			UserListCommand userListCommand2 = new UserListCommand(sqlSession);
			String response = userListCommand2.getAiResponse(userInput);

			// UTF-8로 인코딩
			byte[] bytes = response.getBytes(StandardCharsets.UTF_8);
			return new String(bytes, StandardCharsets.UTF_8);
		}
		//아이디어 작성 ai
		@RequestMapping(value = "/getAiResponse1", method = RequestMethod.POST, consumes = "application/json", produces = "application/json;charset=UTF-8")
		@ResponseBody
		public String getAiResponse(@RequestBody String payload, HttpSession session) {
			Gson gson = new Gson();
			Map<String, String> responseMap = new HashMap<>();

			try {
				// payload를 Map으로 변환
				Map<String, String> requestMap = gson.fromJson(payload, Map.class);

				String userInput = requestMap.get("userInput");
				int roomId;
				Object roomIdObj = requestMap.get("roomId");
				if (roomIdObj instanceof Number) {
					roomId = ((Number) roomIdObj).intValue();
				} else if (roomIdObj instanceof String) {
					roomId = Integer.parseInt((String) roomIdObj);
				} else {
					throw new IllegalArgumentException("Invalid roomId type");
				}
				int userId = (Integer) session.getAttribute("userId");

				String response = aiService2.getAiResponse(userInput);

				// AI 로그 저장
				AiDao aiDao = sqlSession.getMapper(AiDao.class);
				aiDao.insertAiLog(userId, roomId, userInput, response);

				responseMap.put("aiResponse", response);
			} catch (Exception e) {
				System.err.println("Error in getAiResponse: " + e.getMessage());
				e.printStackTrace();
				responseMap.put("error", "An error occurred: " + e.getMessage());
			}

	// Map을 JSON 문자열로 변환하여 반환
			return gson.toJson(responseMap);
		}
		//나의 ai 이력
		@RequestMapping(value = "/getUserAiLog", produces = MediaType.APPLICATION_JSON_VALUE + ";charset=UTF-8")
		@ResponseBody
		public String getUserAiLog(@RequestParam("userId") int userId, @RequestParam("roomId") int roomId) {
		    Gson gson = new Gson();
		    try {
		        AiDao aiDao = sqlSession.getMapper(AiDao.class);
		        List<AiLogDto> logs = aiDao.getUserAilog(userId, roomId);
		        String jsonResponse = gson.toJson(logs);
		        // UTF-8로 인코딩
		        byte[] bytes = jsonResponse.getBytes(StandardCharsets.UTF_8);
		        return new String(bytes, StandardCharsets.UTF_8);
		    } catch (Exception e) {
		        e.printStackTrace();
		        Map<String, String> errorResponse = new HashMap<>();
		        errorResponse.put("error", "Error occurred: " + e.getMessage());
		        String jsonError = gson.toJson(errorResponse);
		        // 에러 응답도 UTF-8로 인코딩
		        byte[] errorBytes = jsonError.getBytes(StandardCharsets.UTF_8);
		        return new String(errorBytes, StandardCharsets.UTF_8);
		    }
		}
	@RequestMapping("/makeRoom")
	public String makeRoom(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new makeRoomCommand(sqlSession);
		command.execute(model);
		return "redirect:/meetingList";
	}

	@RequestMapping("/roomDetail")
	public String roomDetail(HttpServletRequest request, @RequestParam("roomId") int roomId,

	                         @RequestParam("stage") int stage, Model model,
	                         @RequestParam(value = "ideaId", required = false) Integer ideaId) {
	    HttpSession session = request.getSession();
	    int id = (Integer) session.getAttribute("userId");
	    model.addAttribute("id", id);
	    model.addAttribute("roomId", roomId);
	    model.addAttribute("stage", stage);

	    RoomDao dao = sqlSession.getMapper(RoomDao.class);
	    MeetingRooms info = dao.roomDetailInfo(roomId);
	    model.addAttribute("meetingRoom", info);

	    if (stage >= 3 && ideaId != null) {
	        model.addAttribute("ideaId", ideaId);
	    }

	    switch (stage) {
	        case 1:
	            command = new StageOneCommand(sqlSession);
	            command.execute(model);
	            return "firstMeeting/roomStage1";


	        case 2:
	            command = new RoomStage2Command(sqlSession);
	            command.execute(model);
	         // 세션에서 에러 메시지를 가져와서 모델에 추가
	            String errorMessage = (String) model.asMap().get("Message");
	            if (errorMessage != null) {
	                model.addAttribute("errorMessage", errorMessage);
	                session.removeAttribute("Message"); // 에러 메시지를 세션에서 제거
	            }
	            return "firstMeeting/ideaMeeting";

	        case 3:
	            command = new StageThreeCommand(sqlSession);
	            command.execute(model);
	            return "redirect:/ideaOpinionsList";

	    	case 4:
				command = new StageThreeCommand(sqlSession);
				command.execute(model);
				model.addAttribute("currentTab","smart");
				return "redirect:/ideaOpinions2";

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
		System.out.println("submitIdea()실행되는지");
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

	// 아이디어 초안 타이머 시간내 수정하기
	@RequestMapping("/updateIdea")
	public String updateIdea(HttpServletRequest request, @RequestParam("roomId") int roomId,
			@RequestParam("myIdea") String myIdea, @RequestParam("ideaDetail") String ideaDetail,
			@RequestParam("stage") int stage, Model model) {
		System.out.println("/updateIdea()실행되는지");
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

	// 방정보 수정
	@RequestMapping("/updateRoomInfo")
	public String updateRoomInfo(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new UpdateRoomInfo(sqlSession);
		command.execute(model);
		return "redirect:/roomManagement";
	}

	// 참여자관리화면 방장
	@RequestMapping("/userManagement")
	public String userManagement(HttpSession session, HttpServletRequest request, Model model) {
		Integer departmentId = (Integer) session.getAttribute("departmentId");
		model.addAttribute("request", request);
		model.addAttribute("departmentId", departmentId);
		command = new UserManagement(sqlSession);
		command.execute(model);
		return "ideaRoom/userManagement";
	}

	// 참여자 추가 방장
	@RequestMapping("/addParticipants")
	public String addParticipants(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new AddParticipants(sqlSession);
		command.execute(model);
		return "redirect:/userManagement";
	}

	// 참여자 삭제 방장
	@RequestMapping("/removeParticipant")
	public String removeParticipant(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new RemoveParticipant(sqlSession);
		command.execute(model);
		return "redirect:/userManagement";
	}

	// 참여자 알림발송화면 방장
	@RequestMapping("/sendNotifications")
	public String sendNotifications(HttpSession session, HttpServletRequest request, Model model) {
		Integer departmentId = (Integer) session.getAttribute("departmentId");
		model.addAttribute("request", request);
		model.addAttribute("departmentId", departmentId);
		command = new UserManagement(sqlSession);
		command.execute(model);
		return "ideaRoom/notiSendRoom";
	}

	// 참여자별 알림발송
	@RequestMapping("/sendNotiUser")
	public String sendNotiUser(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new SendNotiUser(sqlSession);
		command.execute(model);
		return "redirect:/userManagement";
	}

	// 미참여자 알림발송
	@RequestMapping("/noPartiNoti")
	public String noPartiNoti(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new NoPartiNoti(sqlSession);
		command.execute(model);
		return "redirect:/sendNotifications";
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

		HttpSession session = request.getSession();
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("id", id);
		
		command = new ManagerIdeaListCommand(sqlSession);
		command.execute(model);

		return "firstMeeting/stage1ClearCopy";
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
		HttpSession session = request.getSession();
		int userId = (Integer) session.getAttribute("userId");
		int roomId = Integer.parseInt((String) request.getParameter("roomId"));
		int stage = Integer.parseInt((String) request.getParameter("stage"));
		model.addAttribute("userId", userId);
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
	
	//테스트용
//	@RequestMapping("/testStage1")
//	public String testStage1(HttpServletRequest request, Model model) {
//		model.addAttribute("roomId", 172);
//		model.addAttribute("stage", 1);
//
//		command = new ManagerIdeaListCommand(sqlSession);
//		command.execute(model);
//		return "firstMeeting/stage1ClearCopy";
//	}


}