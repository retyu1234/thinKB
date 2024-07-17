package com.kb.star.command.firstMeeting;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public class MeetingRoomListCommand implements FirstMeetingCommand {
	SqlSession sqlSession;
	
	public MeetingRoomListCommand(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub

	}

}
