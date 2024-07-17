package com.kb.star.command.login;

import java.io.File;
import java.util.Map;

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
		String fileName = null;
		UserDao dao = sqlSession.getMapper(UserDao.class);
		if (file != null && !file.isEmpty()) {
			fileName = file.getOriginalFilename();
			System.out.println("Uploading file: " + fileName);
			try {
				String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
				File dest = new File(uploadPath + fileName);
				file.transferTo(dest);
				System.out.println("머지?");
				dao.updateProfileImg(userId, fileName);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
