package com.kb.star.command.login;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.dto.UsersDto;
import com.kb.star.util.LoginDao;

public class CheckUser implements LoginCommand {

	SqlSession sqlSession;
	
	@Autowired
	public CheckUser(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		int userId=Integer.parseInt(request.getParameter("userId"));
		String birth=request.getParameter("birth");
		LoginDao dao=sqlSession.getMapper(LoginDao.class);
		UsersDto dto=dao.checkUser(userId, birth);
		
	    if (dto != null) {
	    	System.out.println("췌크"+userId);
	        model.addAttribute("user",dto);
	        model.addAttribute("path","login/passwordChangeModal");
	    }else {
	    	System.out.println("췌크1"+userId);
	        model.addAttribute("error", "사용자 정보가 일치하지 않습니다.");
	        model.addAttribute("path","login/passwordChange");
	    }
	}

}
