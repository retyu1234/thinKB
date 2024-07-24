package com.kb.star.command.addFunction;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.dto.AddVoteDto;
import com.kb.star.dto.AddVoteOptionsDto;
import com.kb.star.util.AddVoteDao;

public class AddVoteOptionsCommand implements AddCommand {

	SqlSession sqlSession;

	public AddVoteOptionsCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int addVoteId = (Integer) map.get("addVoteId");
		int userId = (Integer) map.get("id");

		// 투표 정보
		AddVoteDao dao = sqlSession.getMapper(AddVoteDao.class);
		List<AddVoteOptionsDto> dto = dao.voteOptions(addVoteId);
		model.addAttribute("optionList", dto);
		
		// 투표 결과 출력
		List<AddVoteOptionsDto> voteresult = dao.voteOptionsAfter(addVoteId);
		model.addAttribute("voteresult", voteresult);
		
		// 투표 항목 정보
		AddVoteDto voteInfo = dao.selectVoteByAddVoteId(addVoteId);
		model.addAttribute("voteInfo", voteInfo);
		
		// 투표 참여여부 확인 및 OptionID 가져오기
		Integer optionId = dao.checkVoteParticipation(addVoteId, userId);
		model.addAttribute("votedOptionId", optionId);

	}
}
