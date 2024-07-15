package com.kb.star.command.login;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

public interface LoginCommand {

	public void execute(Model model);
}
