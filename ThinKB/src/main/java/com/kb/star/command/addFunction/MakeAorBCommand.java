package com.kb.star.command.addFunction;

import java.io.File;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kb.star.util.AorBDao;

public class MakeAorBCommand implements AddCommand {

    private SqlSession sqlSession;

    @Autowired
    public MakeAorBCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        MultipartHttpServletRequest request = (MultipartHttpServletRequest) map.get("request");
        AorBDao dao = sqlSession.getMapper(AorBDao.class);
        String testName = request.getParameter("testName");
        MultipartFile variantA = request.getFile("variantA");
        MultipartFile variantB = request.getFile("variantB");

        String fileNameA = null;
        String fileNameB = null;

        try {
            String uploadPath = request.getSession().getServletContext().getRealPath("/upload/");
            if (variantA != null && !variantA.isEmpty()) {
                fileNameA = variantA.getOriginalFilename();
                File destA = new File(uploadPath + fileNameA);
                variantA.transferTo(destA);
                System.out.println("Uploaded file A: " + fileNameA);
            }
            if (variantB != null && !variantB.isEmpty()) {
                fileNameB = variantB.getOriginalFilename();
                File destB = new File(uploadPath + fileNameB);
                variantB.transferTo(destB);
                System.out.println("Uploaded file B: " + fileNameB);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        dao.makeAorB(testName, fileNameA, fileNameB);
    }
}
