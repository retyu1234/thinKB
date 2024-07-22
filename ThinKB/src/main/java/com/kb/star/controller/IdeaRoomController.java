package com.kb.star.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.kb.star.command.report.ReportView;
import com.kb.star.command.room.RoomCommand;
import com.kb.star.command.room.StageOneCommand;
import com.kb.star.command.room.SubmitIdeaCommand;
import com.kb.star.command.room.UserListCommand;
import com.kb.star.command.room.makeRoomCommand;

@Controller
public class IdeaRoomController {

	RoomCommand command = null;
	public SqlSession sqlSession;

	@Autowired
	public IdeaRoomController(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	// 메인에서 회의방 생성버튼 눌렀을때, 동일 부서직원 목록 조회, 저장해서 view로 이동
	@RequestMapping("/newIdeaRoom")
	public String newIdeaRoom(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("userName");
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("name", name);
		model.addAttribute("id", id);
		command = new UserListCommand(sqlSession);
		command.execute(model);
		return "ideaRoom/newRoom";
	}

	@RequestMapping("/makeRoom")
	public String makeRoom(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new makeRoomCommand(sqlSession);
		command.execute(model);
		return "redirect:main";
	}

	// 회의방 stage단계별로 화면이동 다르게
	@RequestMapping("/roomDetail")
	public String roomDetail(HttpServletRequest request, @RequestParam("roomId") int roomId,
			@RequestParam("stage") int stage, Model model) {
		HttpSession session = request.getSession();
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("id", id);
		model.addAttribute("roomId", roomId);
		model.addAttribute("stage", stage);

		switch (stage) {
		case 1:
			command = new StageOneCommand(sqlSession);
			command.execute(model);
//				Map<String, Object> map = model.asMap();
//				Boolean result = (Boolean)map.get("result");
//				if(result!=null && !result) { 
//					//1단계의 status가 0이면 아이디어 등록화면으로 이동
			return "firstMeeting/roomStage1";
//				} else {
//					//1단계의 status가 1이면 아이디어 기다리라고 나옴
//					return "redirect:main";
//				}
		case 2:
			return "redirect:/roomStage2?roomId=" + roomId;
		case 7:
			command = new ReportView(sqlSession);
			command.execute(model);
			return "report/roomStage7";
		default:
			return "main";
		}
	}

	// 아이디어 초안 저장
	@RequestMapping("/submitIdea")
	public String submitIdea(HttpServletRequest request, @RequestParam("roomId") int roomId,
			@RequestParam("myIdea") String myIdea, @RequestParam("ideaDetail") String ideaDetail, Model model) {
		HttpSession session = request.getSession();
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("userId", userId);
		model.addAttribute("roomId", roomId);
		model.addAttribute("myIdea", myIdea);
		model.addAttribute("ideaDetail", ideaDetail);
		command = new SubmitIdeaCommand(sqlSession);
		command.execute(model);
		return "redirect:main";
	}

	/*
	 * @RequestMapping("/saveAiLog") public Map<String, String>
	 * saveAiLog(@RequestParam("myIdea") String myIdea, HttpServletRequest request,
	 * Model model) { HttpSession session = request.getSession(); int id = (Integer)
	 * session.getAttribute("userId"); model.addAttribute("id", id);
	 * model.addAttribute("myIdea", myIdea); command = new
	 * insertAiLogCommand(sqlSession); command.execute(model);
	 * 
	 * 
	 * if (result) { response.put("status", "success"); response.put("message",
	 * "AI 로그가 성공적으로 저장되었습니다."); } else { response.put("status", "error");
	 * response.put("message", "AI 로그 저장에 실패했습니다."); } } catch (Exception e) {
	 * response.put("status", "error"); response.put("message",
	 * "AI 로그 저장 중 오류가 발생했습니다: " + e.getMessage()); }
	 */

}