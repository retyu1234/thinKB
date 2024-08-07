package com.kb.star.command.report;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.google.gson.JsonSyntaxException;
import com.kb.star.util.ReportDao;

public class FakeReport implements ReportCommand{

    private final SqlSession sqlSession;
    private final Gson gson;

    @Autowired
    public FakeReport(SqlSession sqlSession) {
        this.sqlSession = sqlSession;
        this.gson = new Gson();
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        
        System.out.println("Executing FakeReport...");

        // 파라미터 로깅
        System.out.println("userId: " + request.getParameter("userId"));
        System.out.println("roomId: " + request.getParameter("roomId"));
        System.out.println("reportTitle: " + request.getParameter("reportTitle"));
        System.out.println("reportContent: " + request.getParameter("reportContent"));

        int userId = Integer.parseInt(request.getParameter("userId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String reportTitle = request.getParameter("reportTitle");
        String reportContent = request.getParameter("reportContent");

        System.out.println("Parsed userId: " + userId);
        System.out.println("Parsed roomId: " + roomId);

        // reportContent가 null이거나 비어있지 않은지 확인
        if (reportContent == null || reportContent.trim().isEmpty()) {
            System.out.println("Warning: reportContent is empty or null");
            return;
        }

        try {
            // JSON 형식 확인
            JsonObject jsonObject = gson.fromJson(reportContent, JsonObject.class);
            System.out.println("Valid JSON format");
        } catch (JsonSyntaxException e) {
            System.out.println("Invalid JSON format: " + e.getMessage());
            return;
        }

        ReportDao dao = sqlSession.getMapper(ReportDao.class);
        int reportExists = dao.checkFinalReport(roomId);
        System.out.println("Report exists: " + reportExists);

        if (reportExists > 0) {
            System.out.println("Updating existing report...");
            dao.updateReport(roomId, userId, reportTitle, reportContent);
        } else {
            System.out.println("Inserting new report...");
            dao.insertReport(roomId, userId, reportTitle, reportContent);
        }

        System.out.println("FakeReport execution completed.");
    }
}
