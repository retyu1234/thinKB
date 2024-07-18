package com.kb.star.command.addFunction;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.AorBDto;
import com.kb.star.util.AorBDao;

public class ABTestDetail implements AddCommand {

	SqlSession sqlSession;
	@Autowired
	public ABTestDetail(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map = model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		int abTestId = Integer.parseInt(request.getParameter("abTestId"));
		AorBDao dao=sqlSession.getMapper(AorBDao.class);
		AorBDto dto=dao.abTestDetail(abTestId);
		int totalVotes = dto.getResultANum() + dto.getResultBNum();
        double aPercentage = totalVotes > 0 ? (double) dto.getResultANum() / totalVotes * 100 : 0;
        double bPercentage = totalVotes > 0 ? (double) dto.getResultBNum() / totalVotes * 100 : 0;
		model.addAttribute("abtest",dto);
        model.addAttribute("aPercentage", aPercentage);
        model.addAttribute("bPercentage", bPercentage);
        model.addAttribute("totalVotes", totalVotes);
	}

}
