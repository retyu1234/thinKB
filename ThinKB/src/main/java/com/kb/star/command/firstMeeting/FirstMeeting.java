
package com.kb.star.command.firstMeeting;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpSession;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import com.kb.star.dto.IdeaReplys;
import com.kb.star.dto.Ideas;
import com.kb.star.dto.MeetingRooms;

public class FirstMeeting implements FirstMeetingCommand {

	private SqlSession sqlSession;

	@Autowired
	public FirstMeeting(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override public void execute(Model model) {
		}
	}
