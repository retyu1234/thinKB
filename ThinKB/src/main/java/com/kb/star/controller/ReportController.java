package com.kb.star.controller;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.kb.star.command.admin.ApproveReport;
import com.kb.star.command.admin.DepartmentReportList;
import com.kb.star.command.admin.ReportDetailCommand;
import com.kb.star.command.report.FakeReport;
import com.kb.star.command.report.MyReportList;
import com.kb.star.command.report.ReportCommand;
import com.kb.star.command.report.WordSubmit;

@Controller
public class ReportController {

	@Autowired
	private SqlSession sqlSession;
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
			command = new FakeReport(sqlSession, servletContext);
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
	
	
	//부서관리자 보고서 목록 전체 조회
    @RequestMapping("/departmentReportList")
    public String departmentReportList(HttpServletRequest request, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        model.addAttribute("request", request);
        model.addAttribute("userId", userId);
        command = new DepartmentReportList(sqlSession);
        command.execute(model);
        return "/admin/adminReportList";
    }
    //부서관리자 보고서 결재 목록
    @RequestMapping("/departmentReportList2")
    public String departmentReportList2(HttpServletRequest request, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        model.addAttribute("request", request);
        model.addAttribute("userId", userId);
        command = new DepartmentReportList(sqlSession, "pending");
        command.execute(model);
        model.addAttribute("initialTab", "pending"); // 결재대기 탭으로 이동
        return "/admin/adminReportList";
    }
	//부서관리자 특정 보고서 조회(클릭시)
    @RequestMapping("/reportDetail")
    public String reportDetail(HttpServletRequest request, Model model, HttpSession session) {
        Integer userId = (Integer) session.getAttribute("userId");
        model.addAttribute("request", request);
        model.addAttribute("userId", userId);
        command = new ReportDetailCommand(sqlSession);
        command.execute(model);
        return "/admin/reportDetail";
    }
    //부서관리자 보고서 결재
    @RequestMapping("/approveReport")
    public String approveReport(HttpServletRequest request, Model model) {
        model.addAttribute("request", request);
        command = new ApproveReport(sqlSession);
        command.execute(model);
        return "redirect:/departmentReportList";
    }

}
