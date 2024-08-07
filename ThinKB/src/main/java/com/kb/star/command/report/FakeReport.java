package com.kb.star.command.report;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.kb.star.command.room.RoomCommand;
import com.kb.star.util.ReportDao;

public class FakeReport implements ReportCommand{

	SqlSession sqlSession;
	@Autowired
	public FakeReport(SqlSession sqlSession) {
		this.sqlSession=sqlSession;
	}
    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        int userId = Integer.parseInt(request.getParameter("userId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String reportTitle = request.getParameter("reportTitle");
        String reportContent = request.getParameter("reportContent");

        // reportContent가 null이거나 비어있지 않은지 확인
        if (reportContent == null || reportContent.trim().isEmpty()) {
            // 로그를 출력하거나 에러 처리
            System.out.println("Warning: reportContent is empty or null");
            return;
        }

        ReportDao dao = sqlSession.getMapper(ReportDao.class);
        int reportExists = dao.checkFinalReport(roomId);
        if (reportExists > 0) {
            dao.updateReport(roomId, userId, reportTitle, reportContent);
        } else {
            dao.insertReport(roomId, userId, reportTitle, reportContent);
        }
    }

}
