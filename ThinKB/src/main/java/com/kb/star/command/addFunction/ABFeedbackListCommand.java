package com.kb.star.command.addFunction;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.dto.AorBDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.AorBDao;
import com.kb.star.util.UserDao;

public class ABFeedbackListCommand implements AddCommand {

	SqlSession sqlSession;

	public ABFeedbackListCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int userId = (Integer) map.get("userId");

		AorBDao dao = sqlSession.getMapper(AorBDao.class);
		int departmentId = getDepartmentIdForUser(userId); // Implement this method to get department ID from userId
		List<AorBDto> dto = dao.getAorBFeedbackList(departmentId);
		model.addAttribute("feedbackTests", dto);
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
