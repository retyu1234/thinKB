package com.kb.star.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.http.MediaType;

import com.google.gson.Gson;
import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.command.admin.Admin;
import com.kb.star.command.admin.AdminMainCommand;
import com.kb.star.command.admin.AdminMypage;
import com.kb.star.dto.AdminDto;
import com.kb.star.util.AdminDao;

@Controller
public class AdminController {

	AddCommand command = null;
	Admin adminCommand = null;
	@Autowired
	private SqlSession sqlSession;

	// 관리자메인
	@RequestMapping("/adminMain")
	public String adminMain(HttpServletRequest request, Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		
		AdminMainCommand adminMainCommand = new AdminMainCommand(sqlSession);
		adminMainCommand.execute(model);
		
		return "adminMain";
	}
	
	// 베스트 직원 정보 가져오기 (AJAX 요청 처리)
	@RequestMapping(value = "/getBestEmployees", method = RequestMethod.GET, produces = MediaType.APPLICATION_JSON_VALUE)
    @ResponseBody
    public String getBestEmployees(@RequestParam(value = "teamName", required = false) String teamName) {
        // System.out.println("Received request for teamName: " + teamName);
        AdminDao adminDao = sqlSession.getMapper(AdminDao.class);
        List<AdminDto> result = adminDao.getBestEmployees(teamName);
        // System.out.println("직원수 " + result.size() + " employees");
        
        Gson gson = new Gson();
        return gson.toJson(result);
    }
	
	// 회원 관리 
	// 사용자 목록
	@RequestMapping("/userList")
	public String userList(HttpServletRequest request, Model model, HttpSession session) {
		Integer userId = (Integer) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		
		AdminMainCommand adminMainCommand = new AdminMainCommand(sqlSession);
		adminMainCommand.execute(model);
		
		return "/admin/userList";
	}
//	@RequestMapping("/userAdminView")
//	public String userAdminView(HttpSession session,HttpServletRequest request,Model model) {
//		int userId = (Integer) session.getAttribute("userId");
//		model.addAttribute("request",request);
//		model.addAttribute("userId",userId);
//		command = new UserListAdmin(sqlSession);
//		command.execute(model);
//		return "admin/userAdmin";
//	}
	
//	// 사용자 추가
//	@RequestMapping("/addUserView")
//	public String addUser(HttpServletRequest request,Model model) {
//		model.addAttribute("request",request);
//		command = new DepartmentTeam(sqlSession);
//		command.execute(model);
//		return "admin/addUser";
//	}
//	@RequestMapping("/insertUser")
//	public String insertUser(HttpServletRequest request,Model model) {
//		model.addAttribute("request",request);
//		command = new InsertUser(sqlSession);
//		command.execute(model);
//		return "redirect:/userList";
//	}
//	
//	//회원삭제
//	@RequestMapping("/deleteEmployee")
//	public String deleteEmployee(HttpServletRequest request,Model model) {
//		model.addAttribute("request",request);
//		command = new DeleteEmployee(sqlSession);
//		command.execute(model);
//		return "redirect:/userList";
//	}
	//관리자 마이페이지
	//마이페이지
	@RequestMapping("/adminMypage")
	public String mypage(HttpSession session,HttpServletRequest request,Model model) {
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("request", request);
		model.addAttribute("userId",userId);
		adminCommand=new AdminMypage(sqlSession);
		adminCommand.execute(model);
		return "admin/adminMypage";
	}

}
