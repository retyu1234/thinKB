package com.kb.star.command.report;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.dto.IdeaSummaryDto;
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
		ReportDao dao=sqlSession.getMapper(ReportDao.class);
		RoomDao dao1=sqlSession.getMapper(RoomDao.class);
		ReportDetailsDto dto=dao.getReportDetails(roomId);
		ReportDetailsDto dto1=dao.getReportDetailsFirst(roomId);
	    List<IdeaSummaryDto> ideaSummaries = dao.getIdeaSummaries(roomId);
	    model.addAttribute("ideaSummaries", ideaSummaries);
		model.addAttribute("reports",dto);
		model.addAttribute("reportsFirst",dto1);
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
		//왼쪽 사이드바
		
	}

}
