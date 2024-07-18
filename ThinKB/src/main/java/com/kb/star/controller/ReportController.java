package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.report.ReportCommand;
import com.kb.star.command.report.WordSubmit;

@Controller
public class ReportController {

	@Autowired
	private SqlSession sqlSession;
	private ReportCommand command;
	
	@RequestMapping("/submitForm")
	public String submitForm(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		command=new WordSubmit(sqlSession);
		command.execute(model);
		return "report/wordFile";
	}
}
