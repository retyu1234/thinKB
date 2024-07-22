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
		// TODO Auto-generated method stub
		Map<String,Object> map = model.asMap();
		HttpServletRequest request=(HttpServletRequest)map.get("request");
		int userId = Integer.parseInt(request.getParameter("userId"));
		int roomId = Integer.parseInt(request.getParameter("roomId"));
		String reportTitle=request.getParameter("reportTitle");
		String reportContent=request.getParameter("reportContent");
		ReportDao dao=sqlSession.getMapper(ReportDao.class);
        int reportExists = dao.checkFinalReport(roomId);
        if (reportExists > 0) {
            dao.updateReport(roomId, userId, reportTitle, reportContent);
        } else {
            dao.insertReport(roomId, userId, reportTitle, reportContent);
        }
	}

}
