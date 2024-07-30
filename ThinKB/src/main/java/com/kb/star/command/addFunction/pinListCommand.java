package com.kb.star.command.addFunction;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.AorBDto;
import com.kb.star.dto.PinTestsDto;
import com.kb.star.util.AorBDao;
import com.kb.star.util.PinTestsDao;
import com.kb.star.util.UserDao;

public class pinListCommand implements AddCommand {

	SqlSession sqlSession;
	@Autowired
	public pinListCommand(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int userId = (Integer) map.get("userId");

		PinTestsDao dao = sqlSession.getMapper(PinTestsDao.class);
		int departmentId = getDepartmentIdForUser(userId); // Implement this method to get department ID from userId
		List<PinTestsDto> dto = dao.getAllPinTests(departmentId);
		model.addAttribute("pinTests", dto);
		System.out.println(dto);
	}

	private int getDepartmentIdForUser(int userId) {

		int id = userId;
		UserDao dao = sqlSession.getMapper(UserDao.class);
		int departmentId = dao.userDepartmentId(id); // 내 아이디로 부서를 조회함
		System.out.println("departmentId : " + departmentId);
		return departmentId; // Placeholder value
	}
}
