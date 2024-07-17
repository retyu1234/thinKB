package com.kb.star.command.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.UsersDto;
import com.kb.star.util.LoginDao;

public class Login implements LoginCommand {

	SqlSession sqlSession;
	
	@Autowired
	public Login(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String userId=request.getParameter("userId");
		String password=request.getParameter("password");
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		UsersDto dto=dao.login(userId,password);
		String path = "";
		if (dto != null) {
			HttpSession session = request.getSession();
            session.setAttribute("userId", dto.getUserId()); // userId 저장
            session.setAttribute("userName", dto.getUserName()); // userName 저장	
            session.setAttribute("departmentId", dto.getDepartmentId());
            session.setAttribute("teamId", dto.getTeamId());
            model.addAttribute("loginSuccess", true);
		}else {
			model.addAttribute("loginSuccess", false);
		}
	}

}
