package com.kb.star.command.login;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.ContributionDetail;
import com.kb.star.dto.MeetingRoomStats;
import com.kb.star.dto.UserListDto;
import com.kb.star.util.UserDao;

public class Mypage implements LoginCommand {
	
	SqlSession sqlSession;

	@Autowired
	public Mypage(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int userId = (Integer) map.get("userId");
		UserDao dao=sqlSession.getMapper(UserDao.class);
		UserListDto dto=dao.userListUser(userId);
		MeetingRoomStats dto1=dao.getMeetingRoomStats(userId);    
		List<ContributionDetail> dto2 = dao.getUserContributions(userId);
		model.addAttribute("user",dto);
		model.addAttribute("MeetingRoomStats",dto1);
		System.out.println("mypage"+dto1.getCompletedMeetings());
		model.addAttribute("ContributionDetail",dto2);
		
		
	}

}
