package com.kb.star.command.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.AdminDto;
import com.kb.star.util.AdminDao;

public class AdminMainCommand implements Admin{

	SqlSession sqlSession;
	
	@Autowired
	public AdminMainCommand(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	
	@Override
    public void execute(Model model) {
    	
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int userId = (Integer) map.get("userId");
		model.addAttribute("userId", userId);
        
		AdminDao adminDao = sqlSession.getMapper(AdminDao.class);
		
		// 메인 - 프로젝트 결재 현황 갯수
		int pendingCount = adminDao.getReportCount(null);
	    int approvedCount = adminDao.getReportCount(1);
	    int rejectedCount = adminDao.getReportCount(0);
	    model.addAttribute("pendingCount", pendingCount);
	    model.addAttribute("approvedCount", approvedCount);
	    model.addAttribute("rejectedCount", rejectedCount);
		
		// 모든 사용자 정보
        List<AdminDto> userList = adminDao.getUserList();
        model.addAttribute("userList", userList);
     	
        // 베스트 사용량 팀
// 	    List<AdminDto> bestUsage = adminDao.getBestUsage();
// 	    model.addAttribute("bestUsage", bestUsage);
 	    // 팀별 채택률
 	    List<AdminDto> bestApproved = adminDao.getBestApproved();
 	    model.addAttribute("bestUsage", bestApproved);
 		// 팀별 베스트 직원
 		List<AdminDto> bestEmployees = adminDao.getBestEmployees(null);
 	    model.addAttribute("bestEmployees", bestEmployees);
// 	    for(AdminDto employee : bestEmployees)
// 	    System.out.println("베스트직원 : " + employee.getUserName());
 	    
 	    
        
	}

}
