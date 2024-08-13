package com.kb.star.command.report;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.util.Units;
import org.apache.poi.xwpf.usermodel.Document;
import org.apache.poi.xwpf.usermodel.UnderlinePatterns;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.kb.star.util.ReportDao;
import com.kb.star.util.RoomDao;

public class WordSubmit implements ReportCommand {

    private SqlSession sqlSession;
    private ServletContext servletContext;
    private static final Logger logger = LoggerFactory.getLogger(WordSubmit.class);

    @Autowired
    public WordSubmit(SqlSession sqlSession, ServletContext servletContext) {
        this.sqlSession = sqlSession;
        this.servletContext = servletContext;
    }

    @Override
    public void execute(Model model) {
        Map<String, Object> map = model.asMap();
        HttpServletRequest request = (HttpServletRequest) map.get("request");
        ReportDao dao = sqlSession.getMapper(ReportDao.class);
        RoomDao stageDao = sqlSession.getMapper(RoomDao.class);
        String reportTitle = request.getParameter("reportTitle");
        String reportContent = request.getParameter("reportContent");
        int userId = Integer.parseInt(request.getParameter("userId"));
        int roomId = Integer.parseInt(request.getParameter("roomId"));
        String date = request.getParameter("date");
        String departmentName = request.getParameter("departmentName");
        String teamName = request.getParameter("teamName");
        String roomManagerName = request.getParameter("roomManagerName");
        String yesPickUserName = request.getParameter("yesPickUserNames");
        reportContent = processAndSaveImages(reportContent, roomId);
        logger.info("Report Content: " + reportContent);
        
        System.out.println(departmentName + "/" + teamName);
        String realPath = servletContext.getRealPath("/upload");
        String inputPath = realPath + File.separator + "formTemplate.docx";
        String outputPath = realPath + File.separator + "formData_" + roomId + ".docx";

        FileInputStream fis = null;
        FileOutputStream fos = null;
        XWPFDocument document = null;

        try {
            fis = new FileInputStream(inputPath);
            document = new XWPFDocument(fis);

            // 문서 업데이트
            updateWordDocument(document, reportTitle, reportContent, date, departmentName, teamName, roomManagerName,
                    yesPickUserName);
            // DB업데이트추가하는 부분
            int reportExists = dao.checkFinalReport(roomId);
            if (reportExists > 0) {
                dao.updateReport(roomId, userId, reportTitle, reportContent);
            } else {
                dao.insertReport(roomId, userId, reportTitle, reportContent);
            }
            // 스테이지 + 1
            stageDao.updateStage(roomId);

            fos = new FileOutputStream(outputPath);
            document.write(fos);

        } catch (IOException e) {
            logger.error("Error in file operations: ", e);
        } finally {
            try {
                if (fis != null)
                    fis.close();
                if (fos != null)
                    fos.close();
                if (document != null)
                    document.close();
            } catch (IOException e) {
                logger.error("Error closing resources: ", e);
            }
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
                        String imageData = op.get("insert").get("image").asText();
                        String imagePath = saveImageToFileSystem(imageData, roomId, i);
                        ((ObjectNode) op.get("insert")).put("image", imagePath);
                    }
                }
            }

            return mapper.writeValueAsString(rootNode);
        } catch (Exception e) {
            logger.error("Error processing images: ", e);
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

        String fileName = "report_" + roomId + "_image_" + index + "." + imageType;
        String uploadDir = servletContext.getRealPath("/upload/images/");
        File dir = new File(uploadDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        String filePath = new File(uploadDir, fileName).getAbsolutePath();
        
        try (FileOutputStream fos = new FileOutputStream(filePath)) {
            fos.write(imageBytes);
        }

        return "/upload/images/" + fileName;  // 웹 애플리케이션 루트를 기준으로 한 상대 경로 반환
    }

    private void updateWordDocument(XWPFDocument document, String reportTitle, String reportContent, String date,
            String departmentName, String teamName, String roomManagerName, String yesPickUserName) {
        // 일반 텍스트 대체
        for (XWPFParagraph paragraph : new ArrayList<>(document.getParagraphs())) {
            replacePlaceholder(paragraph, reportTitle, reportContent, date, departmentName, teamName, roomManagerName,
                    yesPickUserName);
        }

        // 표 내용 대체
        for (XWPFTable table : document.getTables()) {
            for (XWPFTableRow row : table.getRows()) {
                for (XWPFTableCell cell : row.getTableCells()) {
                    for (XWPFParagraph paragraph : new ArrayList<>(cell.getParagraphs())) {
                        replacePlaceholder(paragraph, reportTitle, reportContent, date, departmentName, teamName,
                                roomManagerName, yesPickUserName);
                    }
                }
            }
        }
    }

    private void replacePlaceholder(XWPFParagraph paragraph, String reportTitle, String reportContent, String date,
            String departmentName, String teamName, String roomManagerName, String yesPickUserName) {
        String paragraphText = paragraph.getText();
        if (paragraphText.contains("{ReportContent}")) {
            try {
                // 기존 런을 모두 제거
                for (int i = paragraph.getRuns().size() - 1; i >= 0; i--) {
                    paragraph.removeRun(i);
                }
                // reportContent의 JSON을 파싱하여 스타일링 적용
                applyHtmlStyling(paragraph, reportContent);
            } catch (Exception e) {
                logger.error("Error applying HTML styling: ", e);
                // 에러 발생 시 일반 텍스트로 대체
                XWPFRun run = paragraph.createRun();
                run.setText(reportContent);
            }
        } else {
            // 다른 플레이스홀더 대체
            if (paragraphText.contains("{ReportTitle}") || paragraphText.contains("{Date}")
                    || paragraphText.contains("{DepartmentName}") || paragraphText.contains("{TeamName}")
                    || paragraphText.contains("{RoomManagerName}") || paragraphText.contains("{YesPickUserName}")) {

                List<XWPFRun> runs = paragraph.getRuns();
                if (runs != null && !runs.isEmpty()) {
                    StringBuilder fullText = new StringBuilder();
                    for (XWPFRun run : runs) {
                        fullText.append(run.getText(0));
                    }

                    String replacedText = replacePlaceholderText(fullText.toString(), reportTitle, reportContent, date,
                            departmentName, teamName, roomManagerName, yesPickUserName);

                    XWPFRun firstRun = runs.get(0);
                    firstRun.setText(replacedText, 0);
                    for (int i = runs.size() - 1; i > 0; i--) {
                        paragraph.removeRun(i);
                    }
                }
            }
        }
    }

    private String replacePlaceholderText(String text, String reportTitle, String reportContent, String date,
            String departmentName, String teamName, String roomManagerName, String yesPickUserName) {
        text = text.replace("{ReportTitle}", reportTitle);
        text = text.replace("{Date}", date);
        text = text.replace("{DepartmentName}", departmentName);
        text = text.replace("{TeamName}", teamName);
        text = text.replace("{RoomManagerName}", roomManagerName);
        text = text.replace("{YesPickUserName}", yesPickUserName);
        return text;
    }

    private boolean isValidHexColor(String color) {
        return color.matches("^[0-9A-Fa-f]{6}$");
    }

    private void applyHtmlStyling(XWPFParagraph paragraph, String jsonContent) {
        logger.info("Received JSON content: " + jsonContent);
        try {
            ObjectMapper mapper = new ObjectMapper();
            JsonNode rootNode = mapper.readTree(jsonContent);
            JsonNode ops = rootNode.get("ops");

            if (ops == null || !ops.isArray()) {
                logger.warn("Invalid JSON structure in reportContent");
                XWPFRun run = paragraph.createRun();
                run.setText(jsonContent);
                return;
            }

            XWPFDocument doc = paragraph.getDocument();
            XWPFParagraph currentParagraph = paragraph;

            for (JsonNode op : ops) {
                if (op.has("insert")) {
                    JsonNode insertNode = op.get("insert");
                    if (insertNode.isTextual()) {
                        // 텍스트 처리
                        String text = insertNode.asText();
                        String[] lines = text.split("\n", -1);  // 빈 줄도 포함

                        for (int i = 0; i < lines.length; i++) {
                            if (i > 0) {
                                currentParagraph = doc.createParagraph();
                            }
                            
                            if (!lines[i].trim().isEmpty()) {
                                XWPFRun run = currentParagraph.createRun();
                                run.setText(lines[i]);

                                if (op.has("attributes")) {
                                    JsonNode attrs = op.get("attributes");
                                    applyAttributes(run, attrs);
                                }
                            }
                        }
                    } else if (insertNode.isObject() && insertNode.has("image")) {
                        // 이미지 처리
                        String imagePath = insertNode.get("image").asText();
                        logger.info("Processing image: " + imagePath);
                        currentParagraph = doc.createParagraph();
                        XWPFRun run = currentParagraph.createRun();
                        addImageToRunFromFile(run, imagePath);
                    }
                }
            }

            // 마지막 빈 단락 제거
            int lastParagraphIndex = doc.getParagraphs().size() - 1;
            if (doc.getParagraphs().get(lastParagraphIndex).getRuns().isEmpty()) {
                doc.removeBodyElement(lastParagraphIndex);
            }

        } catch (Exception e) {
            logger.error("Error parsing JSON content: " + e.getMessage(), e);
            logger.error("Problematic JSON content: " + jsonContent);
            XWPFRun run = paragraph.createRun();
            run.setText(jsonContent);
        }
    }

    private void applyAttributes(XWPFRun run, JsonNode attrs) {
        if (attrs.has("bold") && attrs.get("bold").asBoolean()) {
            run.setBold(true);
        }
        if (attrs.has("italic") && attrs.get("italic").asBoolean()) {
            run.setItalic(true);
        }
        if (attrs.has("underline") && attrs.get("underline").asBoolean()) {
            run.setUnderline(UnderlinePatterns.SINGLE);
        }
        if (attrs.has("color")) {
            String color = attrs.get("color").asText();
            if (color.startsWith("#")) {
                color = color.substring(1);
            }
            run.setColor(color);
        }
        if (attrs.has("size")) {
            String size = attrs.get("size").asText();
            if (!size.isEmpty()) {
                try {
                    int fontSize = Integer.parseInt(size.replaceAll("[^0-9]", ""));
                    run.setFontSize(fontSize);
                } catch (NumberFormatException e) {
                    logger.warn("Invalid font size: " + size);
                }
            }
        }
    }

    private void addImageToRun(XWPFRun run, String base64Image) {
        try {
            String[] parts = base64Image.split(",");
            String imageData = parts.length > 1 ? parts[1] : parts[0]; // 데이터 부분만 추출
            byte[] imageBytes = Base64.getDecoder().decode(imageData);
            
            String imageType = "png"; // 기본값으로 PNG 설정
            if (parts.length > 1 && parts[0].contains("image/")) {
                imageType = parts[0].split("image/")[1].split(";")[0];
            }
            
            int imageFormat = getImageFormat(imageType);
            run.addPicture(new ByteArrayInputStream(imageBytes), imageFormat,
                    "Image", Units.toEMU(300), Units.toEMU(200)); // 크기는 필요에 따라 조정
            logger.info("Image added successfully");
        } catch (Exception e) {
            logger.error("Error adding image: ", e);
        }
    }
    private void addImageToRunFromFile(XWPFRun run, String imagePath) {
        try {
            // 상대 경로를 절대 경로로 변환
            String fullPath = servletContext.getRealPath("/") + imagePath.replaceFirst("^/", "");
            logger.info("Attempting to add image from path: " + fullPath);
            File imageFile = new File(fullPath);
            if (!imageFile.exists()) {
                logger.error("Image file not found: " + fullPath);
                return;
            }

            String imageType = imagePath.substring(imagePath.lastIndexOf('.') + 1).toLowerCase();
            int imageFormat;
            switch (imageType) {
                case "png":
                    imageFormat = Document.PICTURE_TYPE_PNG;
                    break;
                case "jpg":
                case "jpeg":
                    imageFormat = Document.PICTURE_TYPE_JPEG;
                    break;
                case "gif":
                    imageFormat = Document.PICTURE_TYPE_GIF;
                    break;
                default:
                    logger.error("Unsupported image format: " + imageType);
                    return;
            }
            
            try (FileInputStream fis = new FileInputStream(imageFile)) {
                run.addPicture(fis, imageFormat, imageFile.getName(), Units.toEMU(300), Units.toEMU(200));
                logger.info("Image added successfully from file: " + fullPath);
            }
        } catch (Exception e) {
            logger.error("Error adding image from file: " + imagePath, e);
            logger.error("Exception details: ", e);
        }
    }

    private int getImageFormat(String imageType) {
        switch (imageType.toLowerCase()) {
            case "png": return Document.PICTURE_TYPE_PNG;
            case "jpg":
            case "jpeg": return Document.PICTURE_TYPE_JPEG;
            case "gif": return Document.PICTURE_TYPE_GIF;
            default: return Document.PICTURE_TYPE_PNG;
        }
    }

}