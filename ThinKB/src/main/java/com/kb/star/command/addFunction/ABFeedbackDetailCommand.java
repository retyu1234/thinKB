package com.kb.star.command.addFunction;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.AorBDto;
import com.kb.star.dto.UserCommentsDto;
import com.kb.star.dto.UserListDto;
import com.kb.star.util.AorBDao;
import com.kb.star.util.PinTestsDao;
import com.kb.star.util.UserDao;

public class ABFeedbackDetailCommand implements AddCommand {

	SqlSession sqlSession;

	@Autowired
	public ABFeedbackDetailCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		HttpSession session = request.getSession();

		// Assuming userId is stored in the session with the attribute name "userId"
		int userId = (int) session.getAttribute("userId");

		int abTestId = Integer.parseInt(request.getParameter("abTestId"));

		// Get AB test details
		AorBDao aorBDao = sqlSession.getMapper(AorBDao.class);
		AorBDto dto = aorBDao.abTestDetail(abTestId);

		int totalVotes = dto.getResultANum() + dto.getResultBNum();
		System.out.println(totalVotes);
		double aPercentage = totalVotes > 0 ? (double) dto.getResultANum() / totalVotes * 100 : 0;
		double bPercentage = totalVotes > 0 ? (double) dto.getResultBNum() / totalVotes * 100 : 0;

		// Get user details
		UserDao userDao = sqlSession.getMapper(UserDao.class);
		UserListDto userdto = userDao.userListUser(userId);

		// Get comments by abTestId
		PinTestsDao pinTestDao = sqlSession.getMapper(PinTestsDao.class);
		List<UserCommentsDto> comments = pinTestDao.getCommentsByAbTestId(abTestId);
		model.addAttribute("comments", comments);

		model.addAttribute("userId", userId);
		model.addAttribute("abtest", dto);
		model.addAttribute("aPercentage", aPercentage);
		model.addAttribute("bPercentage", bPercentage);
		model.addAttribute("totalVotes", totalVotes);
		model.addAttribute("user", userdto); // Add user details to the model
	}
}
