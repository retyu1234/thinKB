package com.kb.star.command.addFunction;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.PinTestsDto;
import com.kb.star.dto.UserCommentsDto;
import com.kb.star.util.PinTestsDao;

public class PinTestDetailCommand implements AddCommand {

	private SqlSession sqlSession;

	@Autowired
	public PinTestDetailCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");

		String pinTestIdStr = request.getParameter("pinTestId");
		if (pinTestIdStr == null || pinTestIdStr.isEmpty()) {
			throw new IllegalArgumentException("pinTestId parameter is missing");
		}

		int pinTestId;
		try {
			pinTestId = Integer.parseInt(pinTestIdStr);
		} catch (NumberFormatException e) {
			throw new IllegalArgumentException("Invalid pinTestId format: " + pinTestIdStr, e);
		}

		PinTestsDao dao = sqlSession.getMapper(PinTestsDao.class);
		PinTestsDto dto = dao.getPinTestById(pinTestId);
		if (dto == null) {
			throw new IllegalArgumentException("PinTest with ID " + pinTestId + " not found");
		}

		List<UserCommentsDto> comments = dao.getCommentsByPinTestId(pinTestId);
		model.addAttribute("comments", comments);
		model.addAttribute("pinTest", dto);
	}
}
