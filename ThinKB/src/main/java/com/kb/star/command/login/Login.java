package com.kb.star.command.login;

import java.sql.Timestamp;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.ui.Model;

import com.kb.star.dto.UsersDto;
import com.kb.star.util.LoginDao;

public class Login implements LoginCommand {

	SqlSession sqlSession;

	@Autowired
	public Login(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String userId = request.getParameter("userId");
		String plainPassword = request.getParameter("password");
		LoginDao dao = sqlSession.getMapper(LoginDao.class);
		PasswordEncoder encoder = new BCryptPasswordEncoder();
		UsersDto dto = dao.login(userId);
		String path = "";
		if (dto != null && dto.isDelete() == false) {
			if (dto.isAdmin()) {
				// isAdmin이 true일 경우, 암호화되지 않은 비밀번호로 비교
				if (plainPassword.equals(dto.getPassword())) {
					// 로그인 성공 처리
					HttpSession session = request.getSession();
					session.setAttribute("userId", dto.getUserId());
					session.setAttribute("userName", dto.getUserName());
					session.setAttribute("departmentId", dto.getDepartmentId());
					session.setAttribute("teamId", dto.getTeamId());
					session.setAttribute("isAdmin", dto.isAdmin());
					 session.setAttribute("loginTime", new Timestamp(System.currentTimeMillis()));
					model.addAttribute("loginSuccess", true);

				} else {
					// 비밀번호가 일치하지 않을 경우 처리
					model.addAttribute("loginSuccess", false);
				}
			} else {
				// isAdmin이 false일 경우, 암호화된 비밀번호로 비교
				String encryptedPasswordFromDB = dto.getPassword(); // 데이터베이스에서 조회한 암호화된 비밀번호

				// 암호화된 비밀번호를 검증
				boolean passwordMatches = encoder.matches(plainPassword, encryptedPasswordFromDB);

				if (passwordMatches) {
					// 로그인 성공 처리
					HttpSession session = request.getSession();
					session.setAttribute("userId", dto.getUserId());
					session.setAttribute("userName", dto.getUserName());
					session.setAttribute("departmentId", dto.getDepartmentId());
					session.setAttribute("teamId", dto.getTeamId());
					session.setAttribute("isAdmin", dto.isAdmin());
					session.setAttribute("profileImg", dto.getProfileImg());
					 session.setAttribute("loginTime", new Timestamp(System.currentTimeMillis()));
					model.addAttribute("loginSuccess", true);

				} else {
					// 비밀번호가 일치하지 않을 경우 처리
					model.addAttribute("loginSuccess", false);
				}
			}
		} else {
			// 사용자 정보가 없을 경우 처리
			model.addAttribute("loginSuccess", false);

		}
	}
}
