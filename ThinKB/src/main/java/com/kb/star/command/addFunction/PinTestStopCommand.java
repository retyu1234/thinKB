package com.kb.star.command.addFunction;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.ui.Model;

import com.kb.star.util.PinTestsDao;

public class PinTestStopCommand implements AddCommand {

    private SqlSession sqlSession;

    public PinTestStopCommand(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int pinTestId = Integer.parseInt(request.getParameter("pinTestId"));

        PinTestsDao dao = sqlSession.getMapper(PinTestsDao.class);
        dao.updatePinTestStatus(pinTestId);
    }
}
