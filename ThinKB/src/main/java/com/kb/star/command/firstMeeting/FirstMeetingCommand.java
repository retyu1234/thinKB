package com.kb.star.command.firstMeeting;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface FirstMeetingCommand {

	public void execute(Model model);
}
