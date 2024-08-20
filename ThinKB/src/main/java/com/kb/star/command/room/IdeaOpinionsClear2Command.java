package com.kb.star.command.room;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.IdeaOpinionsDao;
import com.kb.star.util.RoomDao;

public class IdeaOpinionsClear2Command implements RoomCommand {

    SqlSession sqlSession;
    
    @Autowired
    public IdeaOpinionsClear2Command(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
    	
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int roomId = Integer.parseInt(map.get("roomId").toString());
        // int ideaId = Integer.parseInt(map.get("ideaId").toString());
        // int stage = Integer.parseInt((String) request.getParameter("stage"));
        model.addAttribute("roomId", roomId);
        // model.addAttribute("ideaId", ideaId);
        // model.addAttribute("stage", stage);
       
        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        model.addAttribute("userId", userId);
        
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        
		// MeetingRooms에서 stage 5로 변경
		ideaOpinionsDao.updateStage5(roomId); 
		
		// 수정
		// 1개 이상 의견 작성한 사람들의 MeetingRoomMembers테이블의 기여도 +1
        // ideaOpinionsDao.updateContribution2(ideaId, userId, roomId); // status의 t/f 검증은 xml파일에서 함
		// ideaOpinionsDao.updateContribution2(roomId);
		
        // StageParticipation에서 참여자별 StageID 5로 새로 생성해서 Status 0으로 일괄 넣기
		List<Integer> users = ideaOpinionsDao.RoomForUserList5(roomId);
		for(Integer userIdd : users) {
			ideaOpinionsDao.insertStageParticipation5(roomId, userIdd);
		}
		// 수정
		

		// roomId, stage값 다시 model에 넣기
		model.addAttribute("roomId", roomId);
	    // model.addAttribute("ideaId", ideaId);
	    model.addAttribute("stage", 5);
	    
	    // 오른쪽 사이드바
	    RoomDao dao = sqlSession.getMapper(RoomDao.class);
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
		
		// 타이머
		String timer = dao.roomTimerInfo(roomId);
		model.addAttribute("timer", timer);
	    
	    // Ideas 테이블에서 Title과 StageID 가져오기
	    List<Ideas> ideasInfo = ideaOpinionsDao.getIdeasInfo2(roomId);
        model.addAttribute("ideasInfo", ideasInfo);
	   
        // 다음단계 넘어가는 알림
        String notification = "아이디어 회의가 종료되어 방장이 최종보고서 작성 중입니다. 회의결과를 확인해주세요! 고생하셨습니다.👏👏";
		for (int user : userIdList) {
			int notiId = user;
			dao.makeNotification(notiId, 0, notification, roomId);
		}
}
}


