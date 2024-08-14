package com.kb.star.command.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.report.ReportCommand;
import com.kb.star.dto.DepartmentReportDto;
import com.kb.star.dto.ReportDetailsDto;
import com.kb.star.dto.ReportMemberDto;
import com.kb.star.util.ReportDao;

public class ReportDetailCommand implements ReportCommand {

	SqlSession sqlSession;
	
	@Autowired
	public ReportDetailCommand(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        
        String reportIdStr = request.getParameter("reportId");
        
        if (reportIdStr != null && !reportIdStr.isEmpty()) {
            int reportId = Integer.parseInt(reportIdStr);
            
            ReportDao dao = sqlSession.getMapper(ReportDao.class);
            ReportDetailsDto reportDetail = dao.getReportDetail(reportId);
            
            List<ReportMemberDto> reportMembers = dao.getReportMember(reportDetail.getRoomId());
            
            model.addAttribute("reportDetail", reportDetail);
            model.addAttribute("reportMembers", reportMembers);
            
            // 보고서 기안팀 + 기안자
            ReportMemberDto reportAuthor = dao.getReportAuthor(reportId);
            model.addAttribute("reportAuthor", reportAuthor);
            
        }
        
        // Integer reportId = (Integer) map.get("reportId");
        // Integer userId = (Integer) map.get("userId");

	}

}
