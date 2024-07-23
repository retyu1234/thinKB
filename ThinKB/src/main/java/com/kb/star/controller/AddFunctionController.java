package com.kb.star.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kb.star.command.addFunction.ABTestDetail;
import com.kb.star.command.addFunction.ABTestList;
import com.kb.star.command.addFunction.ABTestVote;
import com.kb.star.command.addFunction.AddCommand;
import com.kb.star.command.addFunction.AddVoteCommand;
import com.kb.star.command.addFunction.AddVoteOptionsCommand;
import com.kb.star.command.addFunction.MakeAorBCommand;
import com.kb.star.command.addFunction.MakeVoteCommand;
import com.kb.star.command.addFunction.VoteListCommand;
import com.kb.star.command.firstMeeting.MeetingRoomListCommand;
import com.kb.star.command.room.UserListCommand;
import com.kb.star.dto.AddVoteDto;
import com.kb.star.util.AddVoteDao;

@Controller
public class AddFunctionController {
	private static final Logger log = LoggerFactory.getLogger(AddFunctionController.class);

	@Autowired
	private SqlSession sqlSession;

	AddCommand command;

	// A/B테스트 목록
	@RequestMapping("/AorBList")
	public String AorBList(HttpSession session, HttpServletRequest request, Model model) {
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("request", request);
		model.addAttribute("userId", userId);
		command = new ABTestList(sqlSession);
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

	// ab테스트 투표화면
	@RequestMapping("/adTsetdetail")
	public String adTsetdetail(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new ABTestDetail(sqlSession);
		command.execute(model);
		return "/addFunction/userABTest";
	}

	// ab테스트 투표
	@RequestMapping("/abTestVote")
	public String abTestVote(HttpSession session, HttpServletRequest request, Model model) {
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("request", request);
		model.addAttribute("userId", userId);
		command = new ABTestVote(sqlSession);
		command.execute(model);
		return "redirect:/AorBList";
	}

	// ab테스트 투표 결과
	@RequestMapping("/completedTestDetail")
	public String completedTestDetail(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new ABTestDetail(sqlSession);
		command.execute(model);
		return "/addFunction/resultABTest";
	}

	// 투표 생성 폼
	@RequestMapping("/newVote")
	public String newVote(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		String name = (String) session.getAttribute("userName");
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("name", name);
		model.addAttribute("id", id);
		command = new UserListCommand(sqlSession);
		command.execute(model);
		return "addFunction/newVote";
	}

	// 투표 등록
	@RequestMapping("/makeVote")
	public String makeRoom(HttpServletRequest request, Model model) {
		model.addAttribute("request", request);
		command = new MakeVoteCommand(sqlSession);
		command.execute(model);
		return "redirect:/voteList";
	}

	// 진행 중인 투표 목록
	@RequestMapping("/voteList")
    public String voteList(HttpServletRequest request, Model model) {
        HttpSession session = request.getSession();
        int userId = (Integer) session.getAttribute("userId");
        model.addAttribute("id", userId);

        // 기존의 voteListCommand 실행
        command = new VoteListCommand(sqlSession);
        command.execute(model);

        // VoteParticipations에서 사용자의 투표 참여 여부 확인
        AddVoteDao dao = sqlSession.getMapper(AddVoteDao.class);

        List<AddVoteDto> voteList = (List<AddVoteDto>) model.asMap().get("voteList");

        for (AddVoteDto vote : voteList) {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("userId", userId);
            params.put("addVoteId", vote.getAddVoteId());

            Integer optionId = dao.getUserOptionIdForVote(params);
            vote.setVotedOptionId(optionId); // AddVoteDto에 votedOptionId 필드 추가
        }

        model.addAttribute("voteList", voteList);

        return "addFunction/voteList";
    }

	// 투표 완료 상태 업데이트 메소드
	public void updateCompletedStatus() {
		AddVoteDao dao = sqlSession.getMapper(AddVoteDao.class);
		dao.updateCompletedStatus();
	}

	// 투표 화면
	@RequestMapping("/addVote")
	public String addVote(@RequestParam("addVoteId") int addVoteId, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		int id = (Integer) session.getAttribute("userId");
		model.addAttribute("id", id);
		model.addAttribute("addVoteId", addVoteId);
		command = new AddVoteOptionsCommand(sqlSession);
		command.execute(model);
		return "addFunction/addVote";
	}

	// 투표 제출
	@RequestMapping("/submitAddVote")
	public String submitAddVote(HttpServletRequest request, Model model, RedirectAttributes redirectAttributes) {
		HttpSession session = request.getSession();
		int userId = Integer.parseInt(session.getAttribute("userId").toString());

		String addVoteIdStr = request.getParameter("addVoteId");
		String optionIdStr = request.getParameter("optionId");

		if (addVoteIdStr == null || addVoteIdStr.isEmpty() || optionIdStr == null || optionIdStr.isEmpty()) {
			throw new IllegalArgumentException("Invalid parameters");
		}

		int addVoteId = Integer.parseInt(addVoteIdStr);
		int optionId = Integer.parseInt(optionIdStr);

		AddVoteDao dao = sqlSession.getMapper(AddVoteDao.class);

		// 투표 참여자의 optionId 업데이트
		dao.updateVoteParticipation(optionId, addVoteId, userId);

		// 선택된 옵션의 voteCount 증가
		dao.incrementVoteCount(optionId);

		// RedirectAttributes를 사용하여 파라미터 전달
		redirectAttributes.addAttribute("addVoteId", addVoteId);

		return "redirect:/addVoteAfter";
	}

	@RequestMapping("/addVoteAfter")
	public String addVoteAfter(@RequestParam("addVoteId") int addVoteId, HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		int userId = (Integer) session.getAttribute("userId");
		model.addAttribute("id", userId);
		model.addAttribute("addVoteId", addVoteId);
		command = new AddVoteOptionsCommand(sqlSession);
		command.execute(model);
		return "addFunction/addVoteAfter";
	}
}
