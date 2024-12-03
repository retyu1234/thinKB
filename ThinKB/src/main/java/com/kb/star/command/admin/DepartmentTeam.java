package com.kb.star.command.admin;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.Teams;
import com.kb.star.util.UserDao;

public class DepartmentTeam implements UserCommand{

	SqlSession sqlSession;
	
	@Autowired
	public DepartmentTeam(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int departmentId=Integer.parseInt(request.getParameter("departmentId"));
		UserDao dao=sqlSession.getMapper(UserDao.class);
		String departmentName=dao.getdepartmentName(departmentId);
		List<Teams> teamList=dao.getTeamName(departmentId);
		model.addAttribute("teamList",teamList);
		model.addAttribute("departmentName",departmentName);
		model.addAttribute("departmentId",departmentId);
	}

}
