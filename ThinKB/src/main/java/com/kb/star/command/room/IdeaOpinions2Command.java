package com.kb.star.command.room;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.IdeaOpinionsDao;
import com.kb.star.util.RoomDao;


public class IdeaOpinions2Command implements RoomCommand {

    SqlSession sqlSession;
    
    @Autowired
    public IdeaOpinions2Command(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
    	
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int roomId = Integer.parseInt(map.get("roomId").toString());
        int ideaId = Integer.parseInt(map.get("ideaId").toString());
        int stage = Integer.parseInt(map.get("stage").toString());
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        model.addAttribute("stage", stage);

        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        model.addAttribute("userId", userId);
        
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        
        // 방장 ID 가져오기
        int roomManagerId = ideaOpinionsDao.getRoomManagerId(roomId);
        model.addAttribute("roomManagerId", roomManagerId);
        
        // 회의방 참여자 수
        int userCount = ideaOpinionsDao.getUserCount(roomId);
        model.addAttribute("userCount", userCount);
        // 방장전용 - stage3 완료자 수
        int doneUserCount = ideaOpinionsDao.getDoneUserCount2(roomId, ideaId);
        model.addAttribute("doneUserCount", doneUserCount);
        
		// 상세설명 - 토글
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		MeetingRooms info = dao.roomDetailInfo(roomId);
		model.addAttribute("meetingRoom", info);
	    
        // 방 제목
        Ideas idea = ideaOpinionsDao.getIdeaTitleById(ideaId);
        model.addAttribute("ideaTitle", idea.getTitle());

        // 탭별로 이전 의견을 가져오는 로직
        List<IdeaOpinionsDto> previousSmartOpinions = ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, "Smart");
        List<IdeaOpinionsDto> previousPositiveOpinions = ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, "Positive");
        List<IdeaOpinionsDto> previousWorryOpinions = ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, "Worry");
        List<IdeaOpinionsDto> previousStrictOpinions = ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, "Strict");
        model.addAttribute("previousSmartOpinions", previousSmartOpinions);
        model.addAttribute("previousPositiveOpinions", previousPositiveOpinions);
        model.addAttribute("previousWorryOpinions", previousWorryOpinions);
        model.addAttribute("previousStrictOpinions", previousStrictOpinions);

        
        // 현재 탭에 이미 의견을 작성했는지 확인
        String currentTab = (String) map.get("currentTab");
        if (currentTab == null || currentTab.isEmpty()) {
            currentTab = "tab-smart"; // 기본값으로 '객관적관점' 탭 설정
        }
        model.addAttribute("currentTab", currentTab);
        
        // 현재 탭
        String hatColor = getHatColorFromTab(currentTab);
        model.addAttribute("currentHatColor", hatColor);

        // 탭별로 현재 의견 전체를 가져오는 로직
        List<IdeaOpinionsDto> currentOpinions = ideaOpinionsDao.getCurrentOpinionsByHatColor(ideaId, hatColor);
        model.addAttribute("currentOpinions", currentOpinions);
        
        // 각 탭별로 현재 의견을 가져오는 로직
        List<IdeaOpinionsDto> smartOpinions = ideaOpinionsDao.getCurrentOpinionsByHatColor(ideaId, "Smart");
        List<IdeaOpinionsDto> positiveOpinions = ideaOpinionsDao.getCurrentOpinionsByHatColor(ideaId, "Positive");
        List<IdeaOpinionsDto> worryOpinions = ideaOpinionsDao.getCurrentOpinionsByHatColor(ideaId, "Worry");
        List<IdeaOpinionsDto> strictOpinions = ideaOpinionsDao.getCurrentOpinionsByHatColor(ideaId, "Strict");
        model.addAttribute("smartOpinions", smartOpinions);
        model.addAttribute("positiveOpinions", positiveOpinions);
        model.addAttribute("worryOpinions", worryOpinions);
        model.addAttribute("strictOpinions", strictOpinions);
        
        
        // 사용자가 특정 의견에 좋아요를 눌렀는지 확인하여 설정
        for (IdeaOpinionsDto opinion : currentOpinions) {
            opinion.setLikedByCurrentUser(ideaOpinionsDao.checkUserLikedOpinion(userId, opinion.getOpinionID()));
        }

        
        model.addAttribute("previousOpinions", ideaOpinionsDao.getPreviousOpinionsByHatColor(ideaId, hatColor));
        
        
        // 사용자가 작성한 탭 목록 가져오기(사용자가 각 탭에 하나씩만 의견을 달 수 있도록 제한 / 이미 의견을 단 탭을 표시하거나 강조 목적)
        List<String> userCommentedTabs = ideaOpinionsDao.getUserCommentedTabs2(userId, ideaId); 
        model.addAttribute("userCommentedTabs", userCommentedTabs);
        System.out.println("userCommentedTabs : " + userCommentedTabs);
        
        // 현재 탭에 이미 의견을 작성했는지 확인
        String currentHatColor = getHatColorFromTab(currentTab);
        model.addAttribute("currentHatColor", currentHatColor);
        System.out.println("currentHatColor : " + currentHatColor);
        if (userCommentedTabs.contains(currentHatColor)) {
            model.addAttribute("alreadyWritten", true);
        } else {
        	model.addAttribute("alreadyWritten", false);
        }
        
        // 사용자가 작성한 전체 의견 수
        int userOpinionCount = ideaOpinionsDao.getUserOpinionCount2(userId, ideaId);
        model.addAttribute("userOpinionCount", userOpinionCount);
        
        // 1개 이상 의견 작성시 StageParticipation테이블의 status 업데이트
        if (userOpinionCount >= 1) { // 1개 댓글 작성시 
            ideaOpinionsDao.updateStatus2(userId, ideaId, roomId, true);
        } else { // 댓글을 삭제해서 1개 미만으로 떨어질 경우
            ideaOpinionsDao.updateStatus2(userId, ideaId, roomId, false);
        }
        
		// leftSideBar.jsp 출력용
		MeetingRooms meetingRoom = sqlSession.selectOne("com.kb.star.util.RoomDao.roomDetailInfo", roomId);
		model.addAttribute("meetingRoom", meetingRoom);
		
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
		
		// url로 접속 막기
		model.addAttribute("userIdList", userIdList);
		
		// 오른쪽 사이드바 기여도
		int totalContributionNum = dao.totalContributionNum(roomId); // RoomDao
		model.addAttribute("totalContributionNum", totalContributionNum);
		
		int myContributionNum = dao.myContributionNum(roomId, userId); // RoomDao
		model.addAttribute("myContributionNum", myContributionNum);

		// idea에서 stageID = 3인(=선택된 아이디어) 조회해서 model에 담기
		List<Ideas> dto = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto);
		System.out.println("아이디어 오피니언 커맨드" + dto);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", userId);
		params.put("roomId", roomId);
		params.put("ideaId", ideaId);

		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByroomId", params);
		model.addAttribute("roomMessage", roomMessage);
//		int stageId = Integer.parseInt(request.getParameter("stage"));
//		model.addAttribute("stage",stageId);
		// 여기까지 leftSideBar 출력용
		
		
		// 타이머 종료 시간 
        String endTime = ideaOpinionsDao.getEndTime(roomId, ideaId);
        model.addAttribute("timer", endTime);
        boolean isTimerEnded = isTimerEnded(endTime);
        model.addAttribute("isTimerEnded", isTimerEnded);
        // 사용자의 의견 작성 가능 여부를 확인
        boolean canWriteOpinion = !isTimerEnded && userOpinionCount < 4 && !userCommentedTabs.contains(currentHatColor);
        model.addAttribute("canWriteOpinion", canWriteOpinion);
        
    }
    
    private String getHatColorFromTab(String currentTab) {
        switch (currentTab) {
            case "tab-smart": return "Smart";
            case "tab-positive": return "Positive";
            case "tab-worry": return "Worry";
            case "tab-strict": return "Strict";
            default: return "Smart";
        }
    }
    
    private boolean isTimerEnded(String endTime) {
        if (endTime == null) return false;
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date end = sdf.parse(endTime);
            return new Date().after(end);
        } catch (ParseException e) {
            e.printStackTrace();
            return false;
        }
    }
    
}


