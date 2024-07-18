package com.kb.star.command.addFunction;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.AorBDto;
import com.kb.star.util.AorBDao;

public class ABTestList implements AddCommand{

	SqlSession sqlSession;
	@Autowired
	public ABTestList(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object> map=model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		int userId = (Integer) map.get("userId");
		AorBDao dao=sqlSession.getMapper(AorBDao.class);
		List<AorBDto> dto=dao.getAorBList(userId);
		model.addAttribute("abTests", dto);
	}

}
