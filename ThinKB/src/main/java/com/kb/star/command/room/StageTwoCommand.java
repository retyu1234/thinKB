package com.kb.star.command.room;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.IdeaReplys;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;

public class StageTwoCommand implements RoomCommand {
	
	SqlSession sqlSession;

	@Autowired
	public StageTwoCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int roomId = (Integer) map.get("roomId");
		int stage = (Integer) map.get("stage");
		String roomTitle = sqlSession.selectOne("com.kb.star.util.IdeaDao.selectRoomTitleById", roomId);
	    model.addAttribute("roomTitle", roomTitle);
	    
	    // 기존 FirstMeetingController의 로직을 가져와서 여기에 추가합니다.
	    MeetingRooms meetingRoom = sqlSession.selectOne("com.kb.star.util.IdeaDao.selectByTitle", roomTitle);
	    model.addAttribute("meetingRoom", meetingRoom);

	    // 아이디어 목록을 RoomID로 조회하여 모델에 추가
	    Map<String, Object> params = new HashMap<String, Object>();
	    params.put("roomId", meetingRoom.getRoomId());

	    List<Ideas> ideas = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeas", params);
	    model.addAttribute("ideas", ideas);

	    List<IdeaReplys> ideaReplys = sqlSession.selectList("com.kb.star.util.IdeaDao.selectIdeaReplys", params);
	    model.addAttribute("ideaReplys", ideaReplys);

	    // 투표 상태 확인
//	    Integer userId = (Integer) session.getAttribute("userId");
	    int userId = (Integer) map.get("id");
	    params.put("userId", userId);
	    params.put("stageId", 2);
	    Integer votedIdeaId = sqlSession.selectOne("com.kb.star.util.IdeaDao.getVotedIdeaId", params);
	    model.addAttribute("votedIdeaId", votedIdeaId);
	    boolean hasVoted = votedIdeaId != null;
	    model.addAttribute("hasVoted", hasVoted);

	    model.addAttribute("roomId", roomId);
	    model.addAttribute("stage", stage);
	}

}
