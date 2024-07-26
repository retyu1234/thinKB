package com.kb.star.command.roomManger;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.util.NotiDao;

public class AllReadCommand implements AddCommand {
	
	SqlSession sqlSession;

	@Autowired
	public AllReadCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String userId = (String) request.getParameter("userId");
		int id = Integer.parseInt(userId);
		
		NotiDao dao = sqlSession.getMapper(NotiDao.class);
		int updatedRows = dao.allReadNotification(id);
		
		model.addAttribute("updatedRows", updatedRows);
	}

}
