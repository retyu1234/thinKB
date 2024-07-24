package com.kb.star.command.room;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.UserDao;
// session에 담긴 id로 나와 같은 부서 사람들 목록을 찾아서 model에 담는 service
public class UserListCommand implements RoomCommand, AddCommand {
	
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
		String department = dao.userDepartment(id); // 내 아이디로 부서를 조회함
		System.out.println("department : " + department );
		List<UsersDto> dto = dao.userList(department, id); // 위에서 조회한 부서와 동일한 사람목록 담음
		model.addAttribute("list", dto);

	}

}
