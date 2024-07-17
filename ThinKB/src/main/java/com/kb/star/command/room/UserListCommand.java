package com.kb.star.command.room;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.UsersDto;
import com.kb.star.util.UserDao;

public class UserListCommand implements RoomCommand {
	
	SqlSession sqlSession;
	
	@Autowired
	public UserListCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		String name = (String) map.get("name");
		int id = (Integer) map.get("id");
		
		UserDao dao = sqlSession.getMapper(UserDao.class);
		String department = dao.userDepartment(name);
		System.out.println("department : " + department );
		List<UsersDto> dto = dao.userList(department, id);
		model.addAttribute("list", dto);

	}

}
