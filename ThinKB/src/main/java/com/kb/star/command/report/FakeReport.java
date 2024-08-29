package com.kb.star.command.report;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Base64;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.kb.star.util.ReportDao;

public class FakeReport implements ReportCommand{

	SqlSession sqlSession;
	ServletContext servletContext;
	@Autowired
	public FakeReport(SqlSession sqlSession,ServletContext servletContext) {
		this.sqlSession=sqlSession;
		this.servletContext = servletContext;
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
        reportContent = processAndSaveImages(reportContent, roomId);
        
        ReportDao dao = sqlSession.getMapper(ReportDao.class);
        int reportExists = dao.checkFinalReport(roomId);
        if (reportExists > 0) {
            dao.updateReport(roomId, userId, reportTitle, reportContent);
        } else {
            dao.insertReportFalse(roomId, userId, reportTitle, reportContent);
        }
    }

    private String processAndSaveImages(String jsonContent, int roomId) {
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode rootNode = mapper.readTree(jsonContent);
            JsonNode ops = rootNode.get("ops");

            if (ops != null && ops.isArray()) {
                for (int i = 0; i < ops.size(); i++) {
                    JsonNode op = ops.get(i);
                    if (op.has("insert") && op.get("insert").isObject() && op.get("insert").has("image")) {
                        String base64Image = op.get("insert").get("image").asText();
                        String imagePath = saveImageToFileSystem(base64Image, roomId, i);
                        ((ObjectNode) op.get("insert")).put("image", imagePath);
                    }
                }
            }

            return mapper.writeValueAsString(rootNode);
        } catch (Exception e) {
            return jsonContent;
        }
    }

    private String saveImageToFileSystem(String base64Image, int roomId, int index) throws IOException {
        String[] parts = base64Image.split(",");
        String imageData = parts.length > 1 ? parts[1] : parts[0];
        byte[] imageBytes = Base64.getDecoder().decode(imageData);

        String imageType = "png";
        if (parts.length > 1 && parts[0].contains("image/")) {
            imageType = parts[0].split("image/")[1].split(";")[0];
        }

        String fileName = "temp_report_" + roomId + "_image_" + index + "." + imageType;
        String uploadDir = servletContext.getRealPath("/upload/temp_images/");
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String filePath = uploadDir + fileName;
        
        try (FileOutputStream fos = new FileOutputStream(filePath)) {
            fos.write(imageBytes);
        }

        return "./upload/temp_images/" + fileName;
    }
}
