package com.kb.star.command.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.util.UserDao;

public class DeleteEmployee implements UserCommand {

	SqlSession sqlSession;
	
	@Autowired
	public DeleteEmployee(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int userId = Integer.parseInt(request.getParameter("userId"));
		UserDao dao=sqlSession.getMapper(UserDao.class);
		dao.deleteUser(userId, true);
	}

}
