package com.kb.star.command.report;

import java.io.ByteArrayInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.kb.star.util.ReportDao;
import com.kb.star.util.RoomDao;

public class WordSubmit implements ReportCommand {

	private SqlSession sqlSession;
	private ServletContext servletContext;

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
			dao.updateReport(roomId, userId, reportTitle, reportContent);
			// 스테이지 + 1
			stageDao.updateStage(roomId);

			fos = new FileOutputStream(outputPath);
			document.write(fos);

		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			try {
				if (fis != null)
					fis.close();
				if (fos != null)
					fos.close();
				if (document != null)
					document.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	private void updateWordDocument(XWPFDocument document, String reportTitle, String reportContent, String date,
			String departmentName, String teamName, String roomManagerName, String yesPickUserName) {
		// 일반 텍스트 대체
		for (XWPFParagraph paragraph : document.getParagraphs()) {
			replacePlaceholder(paragraph, reportTitle, reportContent, date, departmentName, teamName, roomManagerName,
					yesPickUserName);
		}

		// 표 내용 대체
		for (XWPFTable table : document.getTables()) {
			for (XWPFTableRow row : table.getRows()) {
				for (XWPFTableCell cell : row.getTableCells()) {
					for (XWPFParagraph paragraph : cell.getParagraphs()) {
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
			// 기존 런을 모두 제거하는 대신, 첫 번째 런만 남기고 나머지를 제거
			List<XWPFRun> runs = paragraph.getRuns();
			for (int i = runs.size() - 1; i >= 0; i--) {
				paragraph.removeRun(i);
			}
			if (!runs.isEmpty()) {
				XWPFRun firstRun = runs.get(0);
				firstRun.setText("", 0); // 첫 번째 런의 텍스트를 지움
				applyHtmlStyling(paragraph, reportContent);
			} else {
				// 런이 없는 경우 새로운 런을 생성
				applyHtmlStyling(paragraph, reportContent);
			}
		} else {
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

					// 첫 번째 런에 전체 텍스트를 설정하고 나머지 런을 제거
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

	private String extractTextFromHtml(String html) {
		// 간단한 HTML 태그 제거
		return html.replaceAll("<[^>]*>", "");
	}

	private boolean isValidHexColor(String color) {
		return color.matches("^[0-9A-Fa-f]{6}$");
	}

	private void applyHtmlStyling(XWPFParagraph paragraph, String jsonContent) {
		try {
			ObjectMapper mapper = new ObjectMapper();
			JsonNode rootNode = mapper.readTree(jsonContent);
			JsonNode ops = rootNode.get("ops");

			for (JsonNode op : ops) {
				XWPFRun run = paragraph.createRun();

				if (op.has("insert")) {
					if (op.get("insert").isTextual()) {
						String text = op.get("insert").asText();
						run.setText(text);

						if (text.equals("\n")) {
							run.addBreak();
						}
					} else if (op.get("insert").has("image")) {
						String imageData = op.get("insert").get("image").asText();
						addImageToRun(run, imageData);
					}
				}

				if (op.has("attributes")) {
					JsonNode attrs = op.get("attributes");

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
						if (isValidHexColor(color)) {
							run.setColor(color);
						} else {
							// 유효하지 않은 색상 값 처리 (예: 기본 검정색 사용)
							run.setColor("000000");
						}
					}
					if (attrs.has("size")) {
						String size = attrs.get("size").asText();
						try {
							int fontSize = Integer.parseInt(size.replaceAll("[^0-9]", ""));
							run.setFontSize(fontSize);
						} catch (NumberFormatException e) {
							// 파싱 실패 시 기본 크기 설정
							run.setFontSize(11);
						}
					}
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	private void addImageToRun(XWPFRun run, String base64Image) {
		try {
			byte[] imageBytes = Base64.getDecoder().decode(base64Image.split(",")[1]);
			String imageType = base64Image.split(",")[0].split("/")[1].split(";")[0];
			run.addPicture(new ByteArrayInputStream(imageBytes), Document.PICTURE_TYPE_PNG, // 이미지 타입에 따라 적절히 변경
					"Image", Units.toEMU(200), Units.toEMU(200)); // 이미지 크기 조정
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
