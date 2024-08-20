package com.kb.star.command.room;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.util.IdeaOpinionsDao;
import com.kb.star.util.RoomDao;

public class IdeaOpinionsClearCommand implements RoomCommand {

    SqlSession sqlSession;
    
    @Autowired
    public IdeaOpinionsClearCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
    	
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int roomId = Integer.parseInt(map.get("roomId").toString());
        int ideaId = Integer.parseInt(map.get("ideaId").toString());
        // int stage = Integer.parseInt((String) request.getParameter("stage"));
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);
        // model.addAttribute("stage", stage);
       
        String currentTab = map.get("currentTab").toString();

        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        model.addAttribute("userId", userId);
        
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
        // 2개 이상 의견 작성한 사람들의 MeetingRoomMembers테이블의 기여도 +1 : 조건에 부합하는지는 xml파일에서 검증
        // ideaOpinionsDao.updateContribution(ideaId, userId, roomId); // status의 t/f 검증은 xml파일에서 함
        ideaOpinionsDao.updateContribution(roomId, userId);
        
        // ideaOpinionsClear.jsp
        // 타이머
        String timer_hours = request.getParameter("timer_hours");
		String timer_minutes = request.getParameter("timer_minutes");
		String timer_seconds = request.getParameter("timer_seconds");
		// 현재 시간 구하고, 타이머 시간 구하기
		int hour = 0;
		int min = 0;
		int sec = 0;
		if (timer_hours != null && !timer_hours.isEmpty()) {
			hour = Integer.parseInt(timer_hours);
		}
		if (timer_minutes != null && !timer_minutes.isEmpty()) {
			min = Integer.parseInt(timer_minutes);
		}
		if (timer_seconds != null && !timer_seconds.isEmpty()) {
			sec = Integer.parseInt(timer_seconds);
		}
		LocalDateTime currentTime = LocalDateTime.now();
		LocalDateTime endTime = currentTime.plusHours(hour).plusMinutes(min).plusSeconds(sec);
		DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
		String formattedTime = endTime.format(formatter); // 이 시간으로 업데이트 하면 됨
		System.out.println("타이머 저장될 시간? " + formattedTime);
		
		// Timer 시간 새로 insert 해주기
		ideaOpinionsDao.updateNewTimer(roomId,ideaId,formattedTime);
		
		// MeetingRooms에서 stage 4로 변경
		ideaOpinionsDao.updateStage(roomId); 
		
		// StageParticipation에서 참여자별 StageID 4로 새로 생성해서 Status 0으로 일괄 넣기
		List<Integer> users = ideaOpinionsDao.RoomForUserList(roomId);
		for(Integer list : users) {
			ideaOpinionsDao.insertStageParticipation(roomId, ideaId, list);
		}
		System.out.println("here"+users);

		// roomId, stage값 다시 model에 넣기
		model.addAttribute("roomId", roomId);
	    model.addAttribute("ideaId", ideaId);
	    model.addAttribute("stage", 4);
	    

	   
    }
}


