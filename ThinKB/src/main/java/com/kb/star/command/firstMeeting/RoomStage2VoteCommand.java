package com.kb.star.command.firstMeeting;

import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;

public class RoomStage2VoteCommand implements RoomCommand {

	private SqlSession sqlSession;

	public RoomStage2VoteCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int ideaId = (Integer) map.get("ideaId");
		String selectedIdea = (String) map.get("selectedIdea");
		int roomId = (Integer) map.get("roomId");
		int userId = (Integer) map.get("userId");

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("ideaId", ideaId);
		params.put("stageId", 2);
		params.put("roomId", roomId);
		params.put("userId", userId);
		params.put("selectedIdea", selectedIdea);

		// 현재 사용자가 등록한 아이디어 id 조회
		Integer userIdeaId = sqlSession.selectOne("com.kb.star.util.IdeaDao.getUserIdeaId", params);
		// 현재 사용자가 선택한 기존 아이디어 조회
		Integer previousIdeaId = sqlSession.selectOne("com.kb.star.util.IdeaDao.getVotedIdeaId", params);

		Integer status = sqlSession.selectOne("com.kb.star.util.IdeaDao.checkParticipationStatus", params);
		System.out.println("status" + status);

		// 본인의 아이디어에 투표 했는지 체크
		if (userIdeaId != null && userIdeaId.equals(ideaId)) {
			model.addAttribute("Message", "본인의 아이디어는 투표할 수 없습니다.");
		} else {

			// 기존 아이디어 투표 수 감소
			if (previousIdeaId != null) {
				sqlSession.update("com.kb.star.util.IdeaDao.decrementPickNum", previousIdeaId);
			}

			// 새로운 아이디어 투표 수 증가 및 참여 상태 업데이트
			sqlSession.update("com.kb.star.util.IdeaDao.incrementPickNum", ideaId);
			sqlSession.update("com.kb.star.util.IdeaDao.updateParticipationStatus", params);

			// 맨 처음 투표일 때만 기여도 추가
			if (status == 0) {
				sqlSession.update("com.kb.star.util.IdeaDao.contributionUpdate", params);
			}
		}

		model.addAttribute("redirectUrl", "/roomDetail?roomId=" + roomId + "&stage=2");
	}
}
