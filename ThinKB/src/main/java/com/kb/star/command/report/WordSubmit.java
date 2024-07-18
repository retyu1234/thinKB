package com.kb.star.command.report;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

public class WordSubmit implements ReportCommand{

	SqlSession sqlSession;
	@Autowired
	public WordSubmit(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		
	}

}
