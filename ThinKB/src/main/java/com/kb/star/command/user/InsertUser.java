package com.kb.star.command.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.ui.Model;

import com.kb.star.dto.UsersDto;
import com.kb.star.util.UserDao;

public class InsertUser implements UserCommand {

	SqlSession sqlSession;

	@Autowired
	public InsertUser(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String userName = request.getParameter("userName");
		String birth = request.getParameter("birth");
		int userId=Integer.parseInt(request.getParameter("userId"));
		int departmentId=Integer.parseInt(request.getParameter("departmentId"));
		int teamId=Integer.parseInt(request.getParameter("teamId"));
		String email = request.getParameter("email");
		UserDao dao = sqlSession.getMapper(UserDao.class);

	}

}
