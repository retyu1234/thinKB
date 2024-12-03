package com.kb.star.command.addFunction;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.dto.AddVoteDto;
import com.kb.star.dto.AddVoteOptionsDto;
import com.kb.star.dto.VoteParticipationsDto;
import com.kb.star.util.AddVoteDao;

public class addVoteAfterCommand implements AddCommand {
	SqlSession sqlSession;

	public addVoteAfterCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {

		Map<String, Object> map = model.asMap();
		int addVoteId = (Integer) map.get("addVoteId");
		int userId = (Integer) map.get("id");

		AddVoteDao dao = sqlSession.getMapper(AddVoteDao.class);
		List<AddVoteOptionsDto> dto = dao.voteOptionsResult(addVoteId);
		model.addAttribute("optionList", dto);

//		List<VoteParticipationsDto> myVote = dao.myVoteResult(addVoteId, userId);
		VoteParticipationsDto myVote = dao.myVoteResult(addVoteId, userId);
		model.addAttribute("myVote", myVote);

		// 투표 항목 정보
		AddVoteDto voteInfo = dao.selectVoteByAddVoteId(addVoteId);
		model.addAttribute("voteInfo", voteInfo);
	}

}
