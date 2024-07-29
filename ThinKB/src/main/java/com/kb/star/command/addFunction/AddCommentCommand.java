package com.kb.star.command.addFunction;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.util.PinTestsDao;

public class AddCommentCommand implements AddCommand {

    private SqlSession sqlSession;

    public AddCommentCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");

        int x = Integer.parseInt(request.getParameter("x"));
        int y = Integer.parseInt(request.getParameter("y"));
        Integer pinTestId = request.getParameter("pinTestId") != null ? Integer.parseInt(request.getParameter("pinTestId")) : null;
        Integer abTestId = request.getParameter("abTestId") != null ? Integer.parseInt(request.getParameter("abTestId")) : null;
        int userId = Integer.parseInt(request.getParameter("userId"));
        String commentText = request.getParameter("commentText");

        PinTestsDao dao = sqlSession.getMapper(PinTestsDao.class);

        if (pinTestId != null) {
            dao.insertCommentPinId(x, y, pinTestId, userId, commentText);
        } else if (abTestId != null) {
            dao.insertComment(x, y, abTestId, userId, commentText);
        } else {
            throw new IllegalArgumentException("Both pinTestId and abTestId are null");
        }
    }
}
