package com.kb.star.command.user;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.login.LoginCommand;
import com.kb.star.dto.MeetingRooms;
import com.kb.star.util.UserDao;

public class UserInfoCommand implements LoginCommand {
	SqlSession sqlSession;

	@Autowired
	public UserInfoCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
		int id = (Integer) map.get("id");
		
		//진행중인 회의방 영역
		UserDao dao = sqlSession.getMapper(UserDao.class);
		List<MeetingRooms> dto = dao.myMeetingRoom(id); //종료안된것중에 젤 최근꺼 세개
		model.addAttribute("roomList", dto);
		
		// 추가 필요한 정보있으면 밑에 추가
	}

}
