package com.kb.star.command.addFunction;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.util.UserCommentsDao;

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
        int abTestId = Integer.parseInt(request.getParameter("abTestId"));
        int userId = Integer.parseInt(request.getParameter("userId"));
        String commentText = request.getParameter("commentText");

        UserCommentsDao dao = sqlSession.getMapper(UserCommentsDao.class);
        dao.insertComment(x, y, abTestId, userId, commentText);
    }
}
