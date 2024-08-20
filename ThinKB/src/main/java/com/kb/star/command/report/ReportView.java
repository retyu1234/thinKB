package com.kb.star.command.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.dto.IdeaSummaryDto;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.dto.NotiDto;
import com.kb.star.dto.ReportDetailsDto;
import com.kb.star.dto.UsersDto;
import com.kb.star.util.ReportDao;
import com.kb.star.util.RoomDao;

public class ReportView implements RoomCommand{

	SqlSession sqlSession;
	@Autowired
	public ReportView(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object>map=model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		int roomId=(Integer)map.get("roomId");
		int id = (Integer) map.get("id");
		ReportDao dao=sqlSession.getMapper(ReportDao.class);
		RoomDao dao1=sqlSession.getMapper(RoomDao.class);
		ReportDetailsDto dto=dao.getReportDetails(roomId);
		ReportDetailsDto dto1=dao.getReportDetailsFirst(roomId);
	    List<IdeaSummaryDto> ideaSummaries = dao.getIdeaSummaries(roomId);
	    model.addAttribute("ideaSummaries", ideaSummaries);
		model.addAttribute("reports",dto);
		model.addAttribute("reportsFirst",dto1);
		MeetingRooms info = dao1.roomDetailInfo(roomId);
		model.addAttribute("info", info);
		//오른쪽 사이드바
		List<Integer> userIdList = dao1.roomIdFormember(roomId);
		List<UsersDto> userList = new ArrayList<UsersDto>();
		for(int ids : userIdList) {
			UsersDto user = dao1.whosMember(ids);
			if(user != null) {
				userList.add(user);
			}
		}
		model.addAttribute("userList", userList);
		model.addAttribute("userIdList", userIdList);
		//왼쪽 사이드바		
		List<Ideas> dto3 = dao1.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto3);
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", id);
		params.put("roomId", roomId);
		List<NotiDto> roomMessage = sqlSession.selectList("com.kb.star.util.NotiDao.getMessagesByRoomId", params);
		model.addAttribute("roomMessage", roomMessage);
		// 오른쪽 사이드바 기여도
		int totalContributionNum = dao1.totalContributionNum(roomId);
		model.addAttribute("totalContributionNum", totalContributionNum);
		
		int myContributionNum = dao1.myContributionNum(roomId, id);
		model.addAttribute("myContributionNum", myContributionNum);
		
		//상단 6개 단계를 위한 yesPickList
		List<Ideas> dto2 = dao1.yesPickIdeaList(roomId);
		model.addAttribute("yesPickList", dto2);
	}

}
