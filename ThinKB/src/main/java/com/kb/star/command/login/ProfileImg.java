package com.kb.star.command.login;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kb.star.util.UserDao;

public class ProfileImg implements LoginCommand {

	SqlSession sqlSession;

	@Autowired
	public ProfileImg(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		MultipartHttpServletRequest request = (MultipartHttpServletRequest) map.get("request");
		int userId = Integer.parseInt(request.getParameter("userId"));
		MultipartFile file = request.getFile("profileImg");
		String profileImgName = request.getParameter("profileImgName");
		HttpSession session = request.getSession(); 
		UserDao dao = sqlSession.getMapper(UserDao.class);
	      if (file != null && !file.isEmpty()) {
	            // 파일이 업로드된 경우
	            String fileName = file.getOriginalFilename();
	            try {
	                String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
	                File dest = new File(uploadPath + fileName);
	                file.transferTo(dest);
	                dao.updateProfileImg(userId, fileName);
	                session.setAttribute("profileImg", fileName);
	            } catch (Exception e) {
	                e.printStackTrace();
	            }
	        } else if (profileImgName != null && !profileImgName.isEmpty()) {
	            // 파일은 업로드되지 않았지만 profileImgName이 제공된 경우 (초기화 버튼 클릭 등)        
	            dao.updateProfileImg(userId, profileImgName);
	            session.setAttribute("profileImg", profileImgName);
	        }
	    }
	}

