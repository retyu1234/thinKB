package com.kb.star.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import com.kb.star.command.addFunction.ABFeedbackDetailCommand;
import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.command.addFunction.AddCommentCommand;
import com.kb.star.command.addFunction.PinTestStopCommand;
import com.kb.star.dto.UserCommentsDto;
import com.kb.star.util.PinTestsDao;

@Controller
public class CoordinatesController {

	@Autowired
	private SqlSession sqlSession;

	private AddCommand command;

	@RequestMapping(value = "/coordinates", method = RequestMethod.POST)
	@ResponseBody
	public String getCoordinates(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		return "Coordinates received";
	}

	@RequestMapping(value = "/addComment", method = RequestMethod.POST)
	@ResponseBody
	public String addComment(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new AddCommentCommand(sqlSession);
		command.execute(model);
		return "Comment received";
	}

	@RequestMapping(value = "/ABFeedback", method = RequestMethod.GET)
	public String ABFeedback(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new ABFeedbackDetailCommand(sqlSession); // 변경된 커맨드 클래스 사용
		command.execute(model);
		return "/addFunction/ABFeedback";
	}

	/* 메모삭제 */
	@RequestMapping(value = "/deleteComment", method = RequestMethod.POST)
	@ResponseBody
	public String deleteComment(@RequestParam("commentId") String commentId, HttpServletResponse response)
			throws IOException {
		PinTestsDao dao = sqlSession.getMapper(PinTestsDao.class);
		boolean success = dao.deleteComment(commentId);

		if (success) {
			response.setStatus(HttpServletResponse.SC_OK);
			return "Comment deleted successfully";
		} else {
			response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
			return "Error deleting comment";
		}
	}

	@RequestMapping(value = "/stopTest", method = RequestMethod.POST)
	@ResponseBody
	public String stopTest(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new PinTestStopCommand(sqlSession);
		command.execute(model);
		return "redirect:/pinList";
	}
}
