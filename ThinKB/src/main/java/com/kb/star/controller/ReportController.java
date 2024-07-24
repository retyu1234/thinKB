package com.kb.star.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.report.FakeReport;
import com.kb.star.command.report.MyReportList;
import com.kb.star.command.report.ReportCommand;
import com.kb.star.command.report.WordSubmit;

@Controller
public class ReportController {

	@Autowired
	private SqlSession sqlSession;
	@Autowired
	private ServletContext servletContext;
	private ReportCommand command;

	@RequestMapping("/reportView")
	public String reportView() {
		return "report/roomStage7";
	}
	//보고서제출,저장
	@RequestMapping("/submitForm")
	public String submitForm(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		 String action = request.getParameter("action");
		 String path=null;
		if ("save".equals(action)) {
			command = new FakeReport(sqlSession);
			command.execute(model);
			path="redirect:/meetingList";
		} else if ("submit".equals(action)) {
			command = new WordSubmit(sqlSession, servletContext);
			command.execute(model);
			path="redirect:/meetingList";
		}
		return path;
	}
	// 나의 보고서 목록
	@RequestMapping("/myReportList")
	public String myReportList(HttpServletRequest request,Model model,HttpSession session ) {
		Integer userId = (Integer) session.getAttribute("userId");
		model.addAttribute("request", request);
		model.addAttribute("userId",userId);
		command=new MyReportList(sqlSession);
		command.execute(model);
		return "/report/myReportList";
	}
}
