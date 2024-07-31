package com.kb.star.command.room;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.RejectLog;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.RoomDao;

public class StageOneCommand implements RoomCommand {
	
	SqlSession sqlSession;

	public StageOneCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int roomId = (Integer) map.get("roomId");
		int stage = (Integer) map.get("stage");
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		MeetingRooms info = dao.roomDetailInfo(roomId);
		model.addAttribute("info", info);
		
		String timer = dao.roomTimerInfo(roomId);
		model.addAttribute("timer", timer);
		
		// 아이디어 참여여부에 따라 페이지 분기를 위한 로직 false=아이디어 안냄/ true=아이디어 냄
/*		int id = (Integer) map.get("id");
		boolean result = dao.isParticipantsStage1(roomId, id);
		model.addAttribute("result", result);
		
		// result가 true라면 원래 입력했던 내용을 수정할 수 있도록 model에 담기
		if(result) {
			List<Ideas> dto = dao.ideaInfo(roomId, id);
			model.addAttribute("submittedIdea", dto.get(0));
			
			if(dto.get(0).isReject()) {
				String rejectContents = dao.rejectLogSelect(dto.get(0).getIdeaID());
				model.addAttribute("rejectContents", rejectContents);
			}
		} 
		*/
		
		// 반려2번 이상인 경우 에러 발생으로 7/25 수정
		int id = (Integer) map.get("id");
		Ideas alreadySubmitIdea = dao.alreadySubmitIdea(roomId, id);
		
		if(alreadySubmitIdea!=null) {
			model.addAttribute("result", true);
			model.addAttribute("submittedIdea", alreadySubmitIdea);
		} else {
			model.addAttribute("result", false);
		}
		
		Ideas alreadyRejectLog = dao.rejectedIdea(roomId, id);		
		
		if(alreadyRejectLog!=null) { // 반려된 아이디어 있다면
			RejectLog rejectLog = dao.whatsRejectLog(alreadyRejectLog.getIdeaID());
			model.addAttribute("rejectResult", true);
			model.addAttribute("rejectContents", rejectLog);
			model.addAttribute("rejectIdeaTitle", alreadyRejectLog.getTitle());
		} else {
			model.addAttribute("rejectResult", false);
		}
		
		// 방참여자중에 몇명이 아이디어 제출했는지 (submit/total)
		int total = dao.totalRoomUsers(roomId);
		model.addAttribute("total", total);
		
		int submit = dao.submitRoomUser(roomId);
		model.addAttribute("submit", submit);
		
		model.addAttribute("stage", stage);
		
		
		//오른쪽 사이드바
		List<Integer> userIdList = dao.roomIdFormember(roomId);
		List<UsersDto> userList = new ArrayList<UsersDto>();
		for(int ids : userIdList) {
			UsersDto user = dao.whosMember(ids);
			if(user != null) {
				userList.add(user);
			}
		}
		model.addAttribute("userList", userList);
	}

}
