package com.kb.star.command.admin;

import java.time.LocalDate;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.BestDto;
import com.kb.star.dto.MeetingRoomStats;
import com.kb.star.dto.ReportLow;
import com.kb.star.dto.TeamDto;
import com.kb.star.dto.UserListDto;
import com.kb.star.util.AdminDao;
import com.kb.star.util.BestDao;
import com.kb.star.util.UserDao;

public class AdminMypage implements Admin {
	
	SqlSession sqlSession;

	@Autowired
	public AdminMypage(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int userId = (Integer) map.get("userId");
		int departmentId = (Integer) map.get("departmentId");
		UserDao dao=sqlSession.getMapper(UserDao.class);
		UserListDto dto=dao.userListUser(userId);
		MeetingRoomStats dto1=dao.getMeetingRoomStatsAdmin(userId);    
		model.addAttribute("user",dto);
		model.addAttribute("MeetingRoomStats",dto1);
		
		// 베스트 
		BestDao bestDao = sqlSession.getMapper(BestDao.class);
		
		// 베스트 직원
		List<BestDto> bestEmployees = bestDao.getBestEmployees();
	    model.addAttribute("bestEmployees", bestEmployees);
	    
	    // 베스트 사용량 팀
	    List<BestDto> bestUsage = bestDao.getBestUsage(departmentId);
	    model.addAttribute("bestUsage", bestUsage);
	    
        // 오늘의 결재 대기 보고서 가져오기
        List<ReportLow> todayReports = getTodayReports();
        model.addAttribute("todayReports", todayReports);

        // 연간 채택된 보고서 가져오기
        List<ReportLow> yearlyAdoptedReports = getYearlyAdoptedReports();
        model.addAttribute("yearlyAdoptedReports", yearlyAdoptedReports);
        
        // 베스트 팀 데이터 가져오기
        List<TeamDto> bestTeams = getBestTeams();
        model.addAttribute("bestTeams", bestTeams);
        
    }

    private List<ReportLow> getTodayReports() {
        AdminDao dao = sqlSession.getMapper(AdminDao.class);
        LocalDate today = LocalDate.now();
        return dao.getTodayReports(today);
    }

    private List<ReportLow> getYearlyAdoptedReports() {
        AdminDao dao = sqlSession.getMapper(AdminDao.class);
        int currentYear = LocalDate.now().getYear();
        return dao.getYearlyAdoptedReports(currentYear);
    }
    private List<TeamDto> getBestTeams() {
        AdminDao dao = sqlSession.getMapper(AdminDao.class);
        return dao.getBestTeams();
    }
		

}
