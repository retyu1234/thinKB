package com.kb.star.command.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCrypt;
import org.springframework.ui.Model;

import com.kb.star.util.LoginDao;

public class UpdatePassword implements LoginCommand {

	SqlSession sqlSession;
	
	@Autowired
	public UpdatePassword(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		int userId=Integer.parseInt(request.getParameter("userId"));
		String newPassword = BCrypt.hashpw(request.getParameter("newPassword"), BCrypt.gensalt());
		LoginDao dao=sqlSession.getMapper(LoginDao.class);
		dao.updatePassword(userId, newPassword);
	}

}
