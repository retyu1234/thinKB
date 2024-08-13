package com.kb.star.command.addFunction;

import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.util.AddVoteDao;

public class submitAddVoteCommand implements AddCommand {
	
	SqlSession sqlSession;

	public submitAddVoteCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int userId = (Integer) map.get("userId");
		int addVoteId = (Integer) map.get("addVoteId");
		int optionId = (Integer) map.get("optionId");
		
		AddVoteDao dao = sqlSession.getMapper(AddVoteDao.class);

		// 투표 참여자의 optionId 업데이트
//		dao.updateVoteParticipation(optionId, addVoteId, userId);
		dao.voteUpdate(optionId, addVoteId, userId);

		// 선택된 옵션의 voteCount 증가
		dao.incrementVoteCount(optionId);
		
		model.addAttribute("addVoteId", addVoteId);
		
	}

}
