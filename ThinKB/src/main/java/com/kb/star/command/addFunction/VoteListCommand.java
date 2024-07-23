package com.kb.star.command.addFunction;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.dto.AddVoteDto;
import com.kb.star.util.AddVoteDao;

public class VoteListCommand implements AddCommand {

    SqlSession sqlSession;

    public VoteListCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        int id = (Integer) map.get("id");

        AddVoteDao dao = sqlSession.getMapper(AddVoteDao.class);
        List<AddVoteDto> dto = dao.myAllVote(id);
        model.addAttribute("voteList", dto);
    }
}
