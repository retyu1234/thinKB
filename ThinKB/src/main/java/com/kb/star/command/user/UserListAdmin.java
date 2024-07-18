package com.kb.star.command.user;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.UserListDto;
import com.kb.star.util.UserDao;

public class UserListAdmin implements UserCommand {

	SqlSession sqlSession;

	@Autowired
	public UserListAdmin(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int userId = (Integer) map.get("userId");

        String searchTerm = request.getParameter("searchTerm") != null ? request.getParameter("searchTerm") : "";
        int page = request.getParameter("page") != null ? Integer.parseInt(request.getParameter("page")) : 1;
        int limit = 10;
        int offset = (page - 1) * limit;

        UserDao dao = sqlSession.getMapper(UserDao.class);
        int departmentId = dao.departmentAdmin(userId);

        Map<String, Object> params = new HashMap();
        params.put("searchTerm", searchTerm);
        params.put("offset", offset);
        params.put("limit", limit);
        params.put("departmentId", departmentId);

        List<UserListDto> userList = dao.searchEmployees(params);
        int totalCount = dao.countEmployees(params);
        int totalPages = (int) Math.ceil((double) totalCount / limit);

        model.addAttribute("userList", userList);
        model.addAttribute("departmentId", departmentId);
        model.addAttribute("currentPage", page);
        model.addAttribute("totalPages", totalPages);
    }

}
