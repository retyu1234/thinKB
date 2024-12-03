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
	private String initialTab;
	
	@Autowired
//	public DepartmentReportList(SqlSession sqlSession) {
//		this.sqlSession=sqlSession;
//	}
	
	// 전체 or 결재대기 탭으로 이동
	public DepartmentReportList(SqlSession sqlSession) {
        this(sqlSession, "all"); // 기본값을 "all"로 설정
    }

    public DepartmentReportList(SqlSession sqlSession, String initialTab) {
        this.sqlSession = sqlSession;
        this.initialTab = initialTab;
    }
    
	@Override
	public void execute(Model model) {
		Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        Integer userId = (Integer) map.get("userId");
        
        // 보고서 리스트
        ReportDao dao = sqlSession.getMapper(ReportDao.class);
        List<DepartmentReportDto> allReports  = dao.getDepartmentReportList(userId);
        
        // 페이지네이션
        int pageSize = 10; // 페이지당 보여줄 아이템 수
        int totalItems = allReports.size();
        int totalPages = (int) Math.ceil((double) totalItems / pageSize);
        int currentPage = 1; // 기본값
        // 현재 페이지 파라미터 처리
        String pageParam = request.getParameter("page");
        if (pageParam != null && !pageParam.isEmpty()) {
            currentPage = Integer.parseInt(pageParam);
        }

        int start = (currentPage - 1) * pageSize;
        int end = Math.min(start + pageSize, totalItems);
        List<DepartmentReportDto> pagedReports = allReports.subList(start, end);

        model.addAttribute("allReports", allReports); // 전체 보고서 리스트
        model.addAttribute("reports", pagedReports); // 페이징된 보고서 리스트
        model.addAttribute("currentPage", currentPage);
        model.addAttribute("totalPages", totalPages);
        
        // 초기 탭 설정 추가
        model.addAttribute("initialTab", initialTab);
        
        // 필터링 - 팀
        List<String> teams = dao.getAllTeams(); 
        model.addAttribute("teams", teams);
        
        
        
        
	}
}
