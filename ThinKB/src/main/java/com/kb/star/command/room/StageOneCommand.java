package com.kb.star.command.room;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.dto.RejectLog;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.NotiDao;
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
		
		//왼쪽 사이드바 알림
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		List<NotiDto> roomMessage = notiDao.getMessagesByIdeaId(id, roomId, 0);
		model.addAttribute("roomMessage", roomMessage);
		
		// 반려내용담기
		List<RejectLog> rejectList = dao.rejectList(roomId, id);
		model.addAttribute("rejectList", rejectList);
		
		// 오른쪽 사이드바 기여도
		int totalContributionNum = dao.totalContributionNum(roomId);
		model.addAttribute("totalContributionNum", totalContributionNum);
		
		int myContributionNum = dao.myContributionNum(roomId, id);
		model.addAttribute("myContributionNum", myContributionNum);
		
		//상단 6개 단계를 위한 yesPickList
		List<Ideas> dto = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto);
	}

}
