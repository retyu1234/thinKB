package com.kb.star.command.report;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.ReportsDto;
import com.kb.star.util.ReportDao;

public class MyReportList implements ReportCommand {

	SqlSession sqlSession;
	@Autowired
	public MyReportList(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String,Object>map=model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");		
		int userId = (Integer) map.get("userId");
		ReportDao dao=sqlSession.getMapper(ReportDao.class);
		List<ReportsDto> dto=dao.getMyReportList(userId);
		model.addAttribute("reportList",dto);
	}

}
