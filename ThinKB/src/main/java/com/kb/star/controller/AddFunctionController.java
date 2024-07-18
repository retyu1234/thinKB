package com.kb.star.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kb.star.command.addFunction.ABTestDetail;
import com.kb.star.command.addFunction.ABTestList;
import com.kb.star.command.addFunction.ABTestVote;
import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.command.addFunction.MakeAorBCommand;

@Controller
public class AddFunctionController {
	private static final Logger log = LoggerFactory.getLogger(AddFunctionController.class);
	@Autowired
	private SqlSession sqlSession;

	AddCommand command;
	// 나의 보고서 목록
	@RequestMapping("/myReportList")
	public String myReportList(Model model) {
		System.out.println("AddFunctionController - myReportList");

		return "/addFunction/myReportList";
	}

	// A/B테스트 목록
	@RequestMapping("/AorBList")
	public String AorBList(HttpSession session,HttpServletRequest request,Model model) {
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("request",request);
		model.addAttribute("userId",userId);
		command=new ABTestList(sqlSession);
		command.execute(model);

		return "/addFunction/AorBList";
	}

	// A/B테스트 생성 form
	@RequestMapping("/makeAorB")
	public String makeAorB() {
		return "/addFunction/makeAorB";
	}

	// A/B 테스트를 생성 후 목록 페이지로 리다이렉트
	@RequestMapping(value = "/processAorB", method = RequestMethod.POST)
	public String processAorB(MultipartHttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new MakeAorBCommand(sqlSession);
		command.execute(model);
		return "redirect:/AorBList";
	}

	// 투표
	@RequestMapping("/vote")
	public String vote(Model model) {
		return "/addFunction/vote";
	}
	//ab테스트 투표화면
	@RequestMapping("/adTsetdetail")
	public String adTsetdetail(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		command=new ABTestDetail(sqlSession);
		command.execute(model);
		return "/addFunction/userABTest"; 
	}
	//ab테스트 투표
	@RequestMapping("/abTestVote")
	public String abTestVote(HttpServletRequest request,Model model) {
		model.addAttribute("request",request);
		command=new ABTestVote(sqlSession);
		command.execute(model);
		return "redirect:/AorBList";
	}

}
