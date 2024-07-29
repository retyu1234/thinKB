package com.kb.star.command.addFunction;

import java.io.File;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kb.star.util.AorBDao;
import com.kb.star.util.PinTestsDao;
import com.kb.star.util.UserDao;

public class MakePinTestCommand implements AddCommand {

    private SqlSession sqlSession;

    @Autowired
    public MakePinTestCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        MultipartHttpServletRequest request = (MultipartHttpServletRequest) map.get("request");
        HttpSession session = request.getSession();
        
        PinTestsDao dao = sqlSession.getMapper(PinTestsDao.class);
        String testName = request.getParameter("testName");
        MultipartFile file = request.getFile("file");

        // 세션에서 userId 가져오기
        Integer userId = (Integer) session.getAttribute("userId");
        if (userId == null) {
            throw new IllegalStateException("User ID is not available in session");
        }

        int departmentId = getDepartmentIdForUser(userId);

        String fileName = null;

        try {
            String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
            if (file != null && !file.isEmpty()) {
                fileName = file.getOriginalFilename();
                File dest = new File(uploadPath + fileName);
                file.transferTo(dest);
                System.out.println("Uploaded file : " + fileName);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        dao.insertPinTest(testName, fileName, userId, departmentId);
    }

    private int getDepartmentIdForUser(int userId) {
        UserDao dao = sqlSession.getMapper(UserDao.class);
        int departmentId = dao.userDepartmentId(userId); // 내 아이디로 부서를 조회함
        System.out.println("departmentId : " + departmentId);
        return departmentId; // Placeholder value
    }
}
