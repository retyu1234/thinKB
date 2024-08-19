package com.kb.star.controller;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.command.room.IdeaOpinions2Command;
import com.kb.star.command.room.IdeaOpinionsClear2Command;
import com.kb.star.command.room.IdeaOpinionsClearCommand;
import com.kb.star.command.room.IdeaOpinionsCommand;
import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.IdeaOpinionsDao;
import com.kb.star.util.RoomDao;


@Controller
public class IdeaOpinionsController {
	
	AddCommand command = null;

	@Autowired
	private SqlSession sqlSession;
	
    // ideaOpinionsList.jsp
    // http://localhost:8080/star/ideaOpinionsList?roomId=49&ideaId=31
    
    // 4가지 의견 한 번에 보기 1
    @RequestMapping("/ideaOpinionsList")
    public String viewOpinions(@RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId, HttpServletRequest request, Model model) {
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        model.addAttribute("request", request);
        
        IdeaOpinionsCommand IdeaOpinionsCommand = new IdeaOpinionsCommand(sqlSession);
        IdeaOpinionsCommand.execute(model);
        return "/firstMeeting/ideaOpinionsList"; 
    }
    
	// ideaOpinions.jsp
	// http://localhost:8080/star/ideaOpinions?roomId=49&ideaId=31&currentTab=tab-smart
	
	// 아이디어 의견을 가져오는 메서드
    @RequestMapping("/ideaOpinions")
    public String getIdeaOpinions(HttpServletRequest request, Model model, ServletRequest session,
    		@RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId,
    		@RequestParam(value = "currentTab", required = false, defaultValue = "tab-smart") String currentTab) {
    	
    	model.addAttribute("request", request);
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        model.addAttribute("currentTab", currentTab);
//        String activeHatColor = getHatColor(currentTab);
//        model.addAttribute("currentTab", activeHatColor);
        
        IdeaOpinionsCommand IdeaOpinionsCommand = new IdeaOpinionsCommand(sqlSession);
        IdeaOpinionsCommand.execute(model);
        
        // 타이머 모델에 담기
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        String timer = ideaOpinionsDao.getEndTime(roomId, ideaId);
        model.addAttribute("timer", timer);
        
        // 방장 ID 가져오기
        int roomManagerId = ideaOpinionsDao.getRoomManagerId(roomId);
        model.addAttribute("roomManagerId", roomManagerId);
        
//        // 세션에서 에러 메시지 가져오기
//        String error = (String) session.getAttribute("error");
//        if (error != null) {
//            model.addAttribute("error", error);
//            session.removeAttribute("error");  // 에러 메시지 사용 후 삭제
//        }

        return "/firstMeeting/ideaOpinions";
    }
    
    private String getHatColor(String currentTab) {
        switch (currentTab) {
            case "tab-smart": return "Smart";
            case "tab-positive": return "Positive";
            case "tab-worry": return "Worry";
            case "tab-strict": return "Strict";
            default: return "Smart";
        }
    }
    
    // 의견 작성시 추가
    @RequestMapping("/addOpinion")
    public String addOpinion(@ModelAttribute IdeaOpinionsDto opinionForm, HttpSession session, 
                             @RequestParam String currentTab, @RequestParam int roomId, @RequestParam int ideaId, Model model) {
    	Integer userId = (Integer) session.getAttribute("userId");
        opinionForm.setUserID(userId);
        opinionForm.setIdeaID(ideaId);
        opinionForm.setCreatedAt(new Timestamp(new Date().getTime())); 

        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        String hatColor = getHatColor(currentTab);
        opinionForm.setHatColor(hatColor);

        int userCount = ideaOpinionsDao.getUserCount(roomId); // 회의방 참여자 수
        int maxComments = (int) Math.ceil((userCount * 2) / 4.0); // 견해별 작성 가능한 최대 의견 수
        int currentOpinionCount = ideaOpinionsDao.getOpinionCountByHatColorAndIdeaId(ideaId, hatColor); // 현재 견해별 의견 수
        int userOpinionCount = ideaOpinionsDao.getUserOpinionCount(userId, ideaId); // 사용자별 등록한 의견 갯수(아이디어별)

        
        // 사용자가 작성한 댓글 수와 작성한 탭 목록을 가져옴
        List<String> userCommentedTabs = ideaOpinionsDao.getUserCommentedTabs(userId, ideaId);
        if (!userCommentedTabs.contains(hatColor)) {
            ideaOpinionsDao.insertOpinion(opinionForm);
            
            // 두 개의 의견 작성 후 status 업데이트
            userOpinionCount = ideaOpinionsDao.getUserOpinionCount(userId, ideaId);
            if (userOpinionCount >= 2) {
                ideaOpinionsDao.updateStatus(userId, ideaId, roomId, true);
            } else {
                ideaOpinionsDao.updateStatus(userId, ideaId, roomId, false);
            }
        }
        
//        if (userCommentedTabs.contains(hatColor)) {
//            model.addAttribute("error", "이미 이 탭에 의견을 작성했습니다.");
//            return "redirect:/ideaOpinions?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
//        }
//        
//        if (currentOpinionCount >= maxComments) {
//            model.addAttribute("error", "댓글 작성 제한 인원을 초과하였습니다.");
//            return "redirect:/ideaOpinions?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
//        }
//        
//        if (userOpinionCount >= 2) {
//            model.addAttribute("error", "필수 댓글 2개 작성을 완료하셨습니다.");
//            return "redirect:/ideaOpinions?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
//        }
//
//        
//        ideaOpinionsDao.insertOpinion(opinionForm);
//        
//        // 두 개의 의견 작성 후 status 업데이트
//        userOpinionCount = ideaOpinionsDao.getUserOpinionCount(userId, ideaId);
//        if (userOpinionCount >= 2) {
//            ideaOpinionsDao.updateStatus(userId, ideaId, roomId, true);
//            model.addAttribute("message", "필수 댓글 2개 작성을 완료하셨습니다.");
//        } else {
//            ideaOpinionsDao.updateStatus(userId, ideaId, roomId, false);
//        }
        
        return "redirect:/ideaOpinions?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
    }

    // 의견 삭제(자신이 작성한 의견일 경우)
    @RequestMapping("/deleteOpinion")
    public String deleteOpinion(@RequestParam int opinionId, 
                                @RequestParam String currentTab,
                                @RequestParam int roomId,
                                @RequestParam int ideaId) {
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        // 의견 삭제 처리
        ideaOpinionsDao.deleteOpinion(opinionId);
        
        // 현재 탭과 roomId, ideaId를 포함하여 리다이렉트
        return "redirect:/ideaOpinions?roomId=" + roomId + "&ideaId=" + ideaId + "&currentTab=" + currentTab;
    }
    
    
    
    // ideaOpinionsClear.jsp
    @RequestMapping("/ideaOpinionsClear")
    public String ideaOpinionsClear(HttpServletRequest request, Model model,
						    		@RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId, HttpSession session) {
    	
    	model.addAttribute("request", request);
    	model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        
        // 방장 사이드탭
        RoomDao dao=sqlSession.getMapper(RoomDao.class);
        MeetingRooms info = dao.roomDetailInfo(roomId);
        model.addAttribute("meetingRoom", info);
        
    	// leftSideBar.jsp 출력용
		// idea에서 stageID = 3인(=선택된 아이디어) 조회해서 model에 담기
		List<Ideas> yesPickList = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", yesPickList);

		
    	Integer userId = (Integer) session.getAttribute("userId");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("roomId", roomId);
		params.put("ideaId", ideaId);

		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByIdeaId", params);
		model.addAttribute("roomMessage", roomMessage);
		// 여기까지 leftSideBar 출력용
		
		//오른쪽 사이드바
		List<Integer> userIdList = dao.roomIdFormember(roomId);
		List<UsersDto> userList = new ArrayList<UsersDto>();
		for(int ids : userIdList) {
			UsersDto user = dao.whosMember(ids);
			if(user != null) {
				userList.add(user);
			}
		}
		model.addAttribute("userList", userList); 
		
		// 오른쪽 사이드바 기여도
		int totalContributionNum = dao.totalContributionNum(roomId); // RoomDao
		model.addAttribute("totalContributionNum", totalContributionNum);
		
		int myContributionNum = dao.myContributionNum(roomId, userId); // RoomDao
		model.addAttribute("myContributionNum", myContributionNum);
		
		// 타이머
		String timer = dao.roomTimerInfo(roomId);
		model.addAttribute("timer", timer);
		
		// Ideas에서 아이디어 StageID 4로 변경
		IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        ideaOpinionsDao.updateIdeaStage(roomId); // ideaId -> roomId 로 변경 : 방 전체의 아이디어 2개 모두 update
		
		// Ideas 테이블에서 Title과 StageID 가져오기
	    List<Ideas> ideasInfo = ideaOpinionsDao.getIdeasInfo(roomId);
        model.addAttribute("ideasInfo", ideasInfo);
        
//		// 다음단계 넘어가는 알림
//        String notification = "'관점별 의견 더 확장하기' 단계가 시작되었습니다! 창의적인 의견을 작성해주세요! 💡";
//		for (int user : userIdList) {
//			int notiId = user;
//			dao.makeNotification(notiId, 0, notification, roomId);
//		}
        
        return "/firstMeeting/ideaOpinionsClear";
    }
    
	// stage 4로 갈 준비
	@RequestMapping("/goStage4")
	public String goStage4(@RequestParam("roomId") int roomId, 
		            	   @RequestParam("ideaId") int ideaId, 
		            	   @RequestParam("currentTab") String currentTab,
		            	   HttpServletRequest request, Model model, HttpSession session) {

		model.addAttribute("request", request);
		model.addAttribute("roomId", roomId);
		model.addAttribute("ideaId", ideaId);
		model.addAttribute("currentTab", currentTab);
		
		// 수정 알림발송
		RoomDao dao=sqlSession.getMapper(RoomDao.class);
		Integer userId = (Integer) session.getAttribute("userId");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("roomId", roomId);
		params.put("ideaId", ideaId);
		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByIdeaId", params);
		model.addAttribute("roomMessage", roomMessage);
		// 여기까지 leftSideBar 출력용
		
		//오른쪽 사이드바
		List<Integer> userIdList = dao.roomIdFormember(roomId);
		List<UsersDto> userList = new ArrayList<UsersDto>();
		for(int ids : userIdList) {
			UsersDto user = dao.whosMember(ids);
			if(user != null) {
				userList.add(user);
			}
		}
		model.addAttribute("userList", userList); 
		
		// 다음단계 넘어가는 알림
        String notification = "'관점별 의견 더 확장하기' 단계가 시작되었습니다! 창의적인 의견을 작성해주세요! 💡";
		for (int user : userIdList) {
			int notiId = user;
			dao.makeNotification(notiId, 0, notification, roomId);
		}
		// 수정
		
		IdeaOpinionsClearCommand ideaOpinionsClearCommand = new IdeaOpinionsClearCommand(sqlSession);
		ideaOpinionsClearCommand.execute(model);

		return "redirect:/ideaOpinionsList2";
	}
    
    
    // 4가지 의견 한 번에 보기 2
    @RequestMapping("/ideaOpinionsList2")
    public String ideaOpinionsList2(@RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId, HttpServletRequest request, Model model) {
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        model.addAttribute("request", request);
        
        IdeaOpinions2Command ideaOpinions2Command = new IdeaOpinions2Command(sqlSession);
        ideaOpinions2Command.execute(model);

        return "/firstMeeting/ideaOpinionsList2"; 
    }

    // ideaOpinions2.jsp
    // http://localhost:8080/star/ideaOpinions2?roomId=49&ideaId=31&currentTab=tab-smart
    
    // 기존 의견들 불러오기
    @RequestMapping("/ideaOpinions2")
    public String viewIdeaDetails(HttpServletRequest request, Model model,
    							@RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId, 
    							@RequestParam(value = "currentTab", required = false) String currentTab) {
    	model.addAttribute("request", request);
    	model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        model.addAttribute("currentTab", currentTab);
//        int stage = Integer.parseInt((String) request.getParameter("stage"));
//        model.addAttribute("stage", stage);
        
        if (currentTab == null || currentTab.isEmpty()) {
            currentTab = "tab-smart";  // 기본값 설정
        }
        model.addAttribute("currentTab", currentTab);
        
        IdeaOpinions2Command ideaOpinions2Command = new IdeaOpinions2Command(sqlSession);
        ideaOpinions2Command.execute(model);

        return "/firstMeeting/ideaOpinions2";
    }
    
    // 의견 작성시 추가 + 현재 의견들 불러오기
    @RequestMapping("/addOpinion2")
    public String addOpinion2(@ModelAttribute IdeaOpinionsDto opinionForm, HttpSession session, Model model,
                             @RequestParam String currentTab, @RequestParam int roomId, @RequestParam int ideaId) {
        
        Integer userId = (Integer) session.getAttribute("userId");
        opinionForm.setUserID(userId);
        opinionForm.setIdeaID(ideaId); 
        opinionForm.setStep(2);
        opinionForm.setCreatedAt(new Timestamp(new Date().getTime()));  // 작성 시간을 설정합니다.
        
        // currentTab에 따라 HatColor를 설정합니다.
        String hatColor;
        switch (currentTab) {
            case "tab-smart":
                hatColor = "Smart";
                break;
            case "tab-positive":
                hatColor = "Positive";
                break;
            case "tab-worry":
                hatColor = "Worry";
                break;
            case "tab-strict":
                hatColor = "Strict";
                break;
            default:
                hatColor = "Smart";
        }
        opinionForm.setHatColor(hatColor);  // HatColor 값을 설정합니다.
        

        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        ideaOpinionsDao.insertOpinion2(opinionForm);
        
        return "redirect:/ideaOpinions2?currentTab=" + currentTab + "&roomId=" + roomId + "&ideaId=" + ideaId;
    }
    
    // 의견 삭제(자신이 작성한 의견일 경우)
    @RequestMapping("/deleteOpinion2")
    public String deleteOpinion2(@RequestParam int opinionId, 
                                @RequestParam String currentTab,
                                @RequestParam int roomId,
                                @RequestParam int ideaId) {
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        // 해당 의견에 대한 모든 좋아요 삭제 처리
        ideaOpinionsDao.deleteLike(opinionId);
        
        // 의견 삭제 처리
        ideaOpinionsDao.deleteOpinion(opinionId);
        
        // 현재 탭과 roomId, ideaId를 포함하여 리다이렉트
        return "redirect:/ideaOpinions2?roomId=" + roomId + "&ideaId=" + ideaId + "&currentTab=" + currentTab;
    }
    
    // 좋아요 
    @RequestMapping(value = "/likeOpinion", method = RequestMethod.POST)
    public String likeOpinion(@RequestParam("opinionId") int opinionId, @RequestParam("like") boolean like, @RequestParam("userId") int userId,
                              @RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId, @RequestParam("currentTab") String currentTab, Model model) {

        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);

        // 사용자가 이미 좋아요를 눌렀는지 확인
        boolean alreadyLiked = ideaOpinionsDao.checkUserLikedOpinion(userId, opinionId);
        
        if (like && !alreadyLiked) {
            // 좋아요 추가 (Empty Heart -> Filled Heart)
            ideaOpinionsDao.addUserLike(userId, opinionId); // 사용자의 좋아요를 추가
            ideaOpinionsDao.increaseLikeNum(opinionId); // 좋아요 수를 1 증가
        } else if (!like && alreadyLiked) {
            // 좋아요 제거 (Filled Heart -> Empty Heart)
            ideaOpinionsDao.removeUserLike(userId, opinionId); // 사용자의 좋아요를 제거
            ideaOpinionsDao.decreaseLikeNum(opinionId); // 좋아요 수를 1 감소
        }

        return "redirect:/ideaOpinions2?roomId=" + roomId + "&ideaId=" + ideaId + "&currentTab=" + currentTab;
    }

    // 사용자가 특정 의견에 좋아요를 눌렀는지 확인하는 메서드
    private boolean checkIfUserLikedOpinion(int userId, int opinionId) {
    	
    	IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        return ideaOpinionsDao.checkUserLikedOpinion(userId, opinionId);
    }
    
	
    // ideaOpinionsClear2.jsp
    @RequestMapping("/ideaOpinionsClear2")
    public String ideaOpinionsClear2(HttpServletRequest request, Model model, HttpSession session,
						    		@RequestParam("roomId") int roomId, @RequestParam("ideaId") int ideaId) {
    	model.addAttribute("request", request);
    	model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        
//        IdeaOpinionsClear2Command ideaOpinionsClear2Command = new IdeaOpinionsClear2Command(sqlSession);
//		ideaOpinionsClear2Command.execute(model);
        
        // 방장 사이드탭
        RoomDao dao=sqlSession.getMapper(RoomDao.class);
        MeetingRooms info = dao.roomDetailInfo(roomId);
        model.addAttribute("meetingRoom", info);
        
        // leftSideBar.jsp 출력용
    	// idea에서 stageID = 3인(=선택된 아이디어) 조회해서 model에 담기
    	List<Ideas> yesPickList = dao.yesPickIdeaList(roomId);
    	model.addAttribute("yesPickList", yesPickList);
    	
    	Integer userId = (Integer) session.getAttribute("userId");
    	Map<String, Object> params = new HashMap<String, Object>();
    	params.put("userId", userId);
    	params.put("roomId", roomId);
    	params.put("ideaId", ideaId);
    	

    	List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByIdeaId", params);
    	model.addAttribute("roomMessage", roomMessage);
    	// 여기까지 leftSideBar 출력용
    	
    	//오른쪽 사이드바
    	List<Integer> userIdList = dao.roomIdFormember(roomId);
    	List<UsersDto> userList = new ArrayList<UsersDto>();
    	for(int ids : userIdList) {
    		UsersDto user = dao.whosMember(ids);
    		if(user != null) {
    			userList.add(user);
    		}
    	}
    	model.addAttribute("userList", userList); 
    	
		// 오른쪽 사이드바 기여도
		int totalContributionNum = dao.totalContributionNum(roomId); // RoomDao
		model.addAttribute("totalContributionNum", totalContributionNum);
		
		int myContributionNum = dao.myContributionNum(roomId, userId); // RoomDao
		model.addAttribute("myContributionNum", myContributionNum);
    	
    	// 타이머
		String timer = dao.roomTimerInfo(roomId);
		model.addAttribute("timer", timer);
		
		// Ideas에서 아이디어 StageID 5로 변경
		IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
		ideaOpinionsDao.updateIdeaStage5(roomId); // ideaId -> roomId 로 변경 : 방 전체의 아이디어 2개 모두 update
    	
		// 2개 이상 의견 작성한 사람들의 MeetingRoomMembers테이블의 기여도 +1
        ideaOpinionsDao.updateContribution2(ideaId, userId, roomId); // status의 t/f 검증은 xml파일에서 함
        
        // StageParticipation에서 참여자별 StageID 5로 새로 생성해서 Status 0으로 일괄 넣기
		List<Integer> users = ideaOpinionsDao.RoomForUserList5(roomId);
		for(Integer list : users) {
			ideaOpinionsDao.insertStageParticipation5(roomId, ideaId, list);
		}
        
    	// Ideas 테이블에서 Title과 StageID 가져오기
        List<Ideas> ideasInfo = ideaOpinionsDao.getIdeasInfo(roomId);
        model.addAttribute("ideasInfo", ideasInfo);
    	
		return "firstMeeting/ideaOpinionsClear2";
    }
    

	// stage 5로 이동 = IdeaRoomController의 case 5 = (방장)보고서 작성화면/(사용자)요약보고서
	@RequestMapping("/goStage5")
	public String goStage5(@RequestParam("roomId") int roomId, HttpServletRequest request,@RequestParam("stage") int stage,HttpSession session, Model model) {

		Integer userId = (Integer) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		model.addAttribute("request", request);
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);
		
		IdeaOpinionsClear2Command ideaOpinionsClear2Command = new IdeaOpinionsClear2Command(sqlSession);
		ideaOpinionsClear2Command.execute(model);
		
		IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
		 // 모든 참가자의 기여도를 한 번에 업데이트
	    ideaOpinionsDao.updateContributionLikeNum(roomId);
	    // 기안자들 +20점
	    ideaOpinionsDao.updateContributionCntForYesPick(roomId);
	    // 업데이트 후 각 참가자의 좋아요 수 로그 출력 (선택적)
	    List<Integer> participantList = ideaOpinionsDao.RoomForUserList5(roomId);
	    for (Integer participantId : participantList) {
	        int likeNum = ideaOpinionsDao.getLikeNum(participantId, roomId);
	        
	    }
	    
//		// 방에 참가한 모든 참여자 목록 가져오기
//		List<Integer> participantList = ideaOpinionsDao.RoomForUserList5(roomId);
//		for (Integer participantId : participantList) {
//	        // 각 참여자의 좋아요 수 가져오기
//	        int likeNum = ideaOpinionsDao.getLikeNum(participantId, roomId); // participantId = roomId에 있는 모든 userList
//	        System.out.println("회의방 참여 userId : " + participantId + "참가한 roomId : " + roomId);
//	        System.out.println("likeNum :" + likeNum);
//	        
//	        // 좋아요 수만큼 MeetingRoomMembers 테이블의 기여도 증가
//	        ideaOpinionsDao.updateContributionLikeNum(participantId, roomId);
//	        System.out.println("userId: " + participantId + "의 기여도 " + likeNum + "만큼 증가 완료");
//	    }

		return "redirect:/roomDetail"; 
	}
}
	
