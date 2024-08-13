package com.kb.star.command.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.report.ReportCommand;
import com.kb.star.dto.DepartmentReportDto;
import com.kb.star.util.ReportDao;

public class DepartmentReportList implements ReportCommand {

	SqlSession sqlSession;
	
	@Autowired
	public DepartmentReportList(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        Integer userId = (Integer) map.get("userId");

        ReportDao dao = sqlSession.getMapper(ReportDao.class);
        List<DepartmentReportDto> reports = dao.getDepartmentReportList(userId);

        model.addAttribute("reports", reports);
	}

}
