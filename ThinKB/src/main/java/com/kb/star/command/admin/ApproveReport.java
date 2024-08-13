package com.kb.star.command.admin;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.report.ReportCommand;
import com.kb.star.util.ReportDao;

public class ApproveReport implements ReportCommand {

	SqlSession sqlSession;
	@Autowired
	public ApproveReport(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        
        String reportIdStr = request.getParameter("reportId");
        if (reportIdStr != null && !reportIdStr.isEmpty()) {
            int reportId = Integer.parseInt(reportIdStr);
            
            ReportDao dao = sqlSession.getMapper(ReportDao.class);
            dao.approveReport(reportId);
        }
	}

}
