package com.kb.star.command.room;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.IdeaOpinionsDto;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRoomMember;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.NotiDao;
import com.kb.star.util.RoomDao;

public class StageEndCommand implements RoomCommand {

	SqlSession sqlSession;

	@Autowired
	public StageEndCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int id = (Integer) map.get("id");
		int roomId = (Integer) map.get("roomId");
//		int ideaId = (Integer) map.get("ideaId");
//		model.addAttribute("ideaId", ideaId);
		MeetingRooms meetingRoom = (MeetingRooms) map.get("meetingRoom");
		model.addAttribute("meetingRoom", meetingRoom);

		// 오른쪽 사이드바
		RoomDao dao = sqlSession.getMapper(RoomDao.class);
		List<Integer> userIdList = dao.roomIdFormember(roomId);
		List<UsersDto> userList = new ArrayList<UsersDto>();
		for (int ids : userIdList) {
			UsersDto user = dao.whosMember(ids);
			if (user != null) {
				userList.add(user);
			}
		}
		model.addAttribute("userList", userList);

		// 왼쪽 사이드바 알림
		NotiDao notiDao = sqlSession.getMapper(NotiDao.class);
		List<NotiDto> roomMessage = notiDao.getMessagesByIdeaId(id, roomId, 0);
		model.addAttribute("roomMessage", roomMessage);

		// 아이디어 정보 담기(전체totalIdea(삭제만 뺴고, 반려포함)/투표된거 두개)
		List<Ideas> totalIdea = dao.totalIdea(roomId);
		model.addAttribute("totalIdea", totalIdea);
		List<Ideas> yesPickList = dao.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", yesPickList);

		// 선택된 두개 아이디어에 대한 의견 담기
		 if (!yesPickList.isEmpty()) {
	            int firstNum = yesPickList.get(0).getIdeaID();
	            List<IdeaOpinionsDto> firstOpinion = dao.ideaIdForOpinion(firstNum);
	            model.addAttribute("firstOpinion", firstOpinion);

	            if (yesPickList.size() > 1) {
	                int secondNum = yesPickList.get(1).getIdeaID();
	                List<IdeaOpinionsDto> secondOpinion = dao.ideaIdForOpinion(secondNum);
	                model.addAttribute("secondOpinion", secondOpinion);
	            } else {
	                model.addAttribute("secondOpinion", new ArrayList<IdeaOpinionsDto>());
	            }
	        } else {
	            model.addAttribute("firstOpinion", new ArrayList<IdeaOpinionsDto>());
	            model.addAttribute("secondOpinion", new ArrayList<IdeaOpinionsDto>());
	        }
		
		// 기여도 조회 담기
		List<MeetingRoomMember> member = dao.memberForRoomId(roomId);
		model.addAttribute("member", member);
		
		// 회의방 참여자 여부 확인
		model.addAttribute("userIdList", userIdList);
	}

}
