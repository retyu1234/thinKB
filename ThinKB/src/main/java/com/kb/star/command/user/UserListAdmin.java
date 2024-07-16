package com.kb.star.command.user;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.UserListDto;
import com.kb.star.util.UserDao;

public class UserListAdmin implements UserCommand {

	SqlSession sqlSession;

	@Autowired
	public UserListAdmin(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int userId = (Integer) map.get("userId");	
        UserDao dao = sqlSession.getMapper(UserDao.class);
        int departmentId =dao.departmentAdmin(userId);
        System.out.println("222 : "+departmentId);
        List<UserListDto> dto=dao.userListAdmin(departmentId);
        model.addAttribute("userList",dto);
        model.addAttribute("departmentId",departmentId);
	}

}
