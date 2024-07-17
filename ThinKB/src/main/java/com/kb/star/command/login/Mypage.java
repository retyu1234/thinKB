package com.kb.star.command.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.UserListDto;
import com.kb.star.util.UserDao;

public class Mypage implements LoginCommand {
	
	SqlSession sqlSession;

	@Autowired
	public Mypage(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int userId = (Integer) map.get("userId");
		UserDao dao=sqlSession.getMapper(UserDao.class);
		UserListDto dto=dao.userListUser(userId);
		model.addAttribute("user",dto);
		
	}

}
