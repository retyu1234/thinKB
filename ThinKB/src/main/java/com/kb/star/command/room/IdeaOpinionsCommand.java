package com.kb.star.command.room;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.util.IdeaOpinionsDao;
import com.kb.star.util.RoomDao;

public class IdeaOpinionsCommand implements RoomCommand {

    SqlSession sqlSession;

    @Autowired
    public IdeaOpinionsCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
    	
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int roomId = Integer.parseInt(map.get("roomId").toString());
        int ideaId = Integer.parseInt(map.get("ideaId").toString());
        model.addAttribute("roomId", roomId);
        model.addAttribute("ideaId", ideaId);

        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        model.addAttribute("userId", userId);

        // 방 제목
        IdeaOpinionsDao ideaOpinionsDao = sqlSession.getMapper(IdeaOpinionsDao.class);
        Ideas idea = ideaOpinionsDao.getIdeaTitleById(ideaId);
        model.addAttribute("ideaTitle", idea.getTitle());
       
        // 탭
        String[] hatColors = {"Smart", "Positive", "Worry", "Strict"};
        for (String hatColor : hatColors) {
            model.addAttribute(hatColor.toLowerCase() + "Opinions", ideaOpinionsDao.findByHatColor(ideaId, hatColor));
        }

        // 회의방 참여자 수
        int userCount = ideaOpinionsDao.getUserCount(roomId);
        model.addAttribute("userCount", userCount);
        // 견해별 작성 가능한 최대 의견 갯수
        int maxComments = (int) Math.ceil((userCount * 2) / 4.0); // 올림 처리
        model.addAttribute("maxComments", maxComments);
        
        for (String hatColor : hatColors) {
            int opinionCount = ideaOpinionsDao.getOpinionCountByHatColorAndIdeaId(ideaId, hatColor);
            model.addAttribute(hatColor.toLowerCase() + "OpinionCount", opinionCount);
        }
        
        // 2개 이상 의견 작성시 StageParticipation테이블의 status 업데이트
        int userOpinionCount = ideaOpinionsDao.getUserOpinionCount(userId, ideaId); // 사용자가 작성한 전체 의견 수
        model.addAttribute("userOpinionCount", userOpinionCount);

        if (userOpinionCount >= 2) { // 2개 댓글 작성시 
            ideaOpinionsDao.updateStatus(userId, ideaId, roomId, true);
        } else { // 댓글을 삭제해서 2개 미만으로 떨어질 경우
            ideaOpinionsDao.updateStatus(userId, ideaId, roomId, false);
        }
        
        // 타이머 종료 시간 
        String endTime = ideaOpinionsDao.getEndTime(roomId, ideaId);
        model.addAttribute("timer", endTime);
        
        // 방장 ID 가져오기
        int roomManagerId = ideaOpinionsDao.getRoomManagerId(roomId);
        model.addAttribute("roomManagerId", roomManagerId);
        
        // 방장전용 - stage3 완료자 수
        int doneUserCount = ideaOpinionsDao.getDoneUserCount(roomId, ideaId);
        model.addAttribute("doneUserCount", doneUserCount);
        
        // 방장 사이드탭
        RoomDao dao=sqlSession.getMapper(RoomDao.class);
        MeetingRooms info = dao.roomDetailInfo(roomId);
        model.addAttribute("meetingRoom", info);
        
		//기여도 +1 추가
        // RoomDao roomDao = sqlSession.getMapper(RoomDao.class);
        // roomDao.updateContribution(roomId, ideaId, userId);
		
        model.addAttribute("opinionForm", new IdeaOpinionsDto());
        model.addAttribute("userOpinions", ideaOpinionsDao.getUserCommentedTabs(userId, ideaId));
        

    }
}
