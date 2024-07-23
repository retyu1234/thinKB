package com.kb.star.command.report;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.apache.poi.xwpf.usermodel.XWPFDocument;
import org.apache.poi.xwpf.usermodel.XWPFParagraph;
import org.apache.poi.xwpf.usermodel.XWPFRun;
import org.apache.poi.xwpf.usermodel.XWPFTable;
import org.apache.poi.xwpf.usermodel.XWPFTableCell;
import org.apache.poi.xwpf.usermodel.XWPFTableRow;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

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
		RoomDao stageDao=sqlSession.getMapper(RoomDao.class);
		String reportTitle = request.getParameter("reportTitle");
		String reportContent = request.getParameter("reportContent");
		int userId = Integer.parseInt(request.getParameter("userId"));
		int roomId = Integer.parseInt(request.getParameter("roomId"));
		String date = request.getParameter("date");
		String departmentName = request.getParameter("departmentName");
		String teamName = request.getParameter("teamName");
		String roomManagerName = request.getParameter("roomManagerName");
		String yesPickUserName = request.getParameter("yesPickUserName");

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
			//DB업데이트추가하는 부분
			dao.updateReport(roomId, userId, reportTitle, reportContent);
			//스테이지 + 1
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
		if (paragraphText.contains("{ReportTitle}") || paragraphText.contains("{ReportContent}")
				|| paragraphText.contains("{Date}") || paragraphText.contains("{DepartmentName}")
				|| paragraphText.contains("{TeamName}") || paragraphText.contains("{RoomManagerName}")
				|| paragraphText.contains("{YesPickUserName}")) {

			List<XWPFRun> runs = paragraph.getRuns();
			if (runs != null) {
				StringBuilder fullText = new StringBuilder();
				for (XWPFRun run : runs) {
					fullText.append(run.getText(0));
				}

				String replacedText = replacePlaceholderText(fullText.toString(), reportTitle, reportContent, date,
						departmentName, teamName, roomManagerName, yesPickUserName);

				int runIndex = 0;
				for (XWPFRun run : runs) {
					if (runIndex == 0) {
						run.setText(replacedText, 0);
					} else {
						run.setText("", 0);
					}
					runIndex++;
				}
			}
		}
	}

	private String replacePlaceholderText(String text, String reportTitle, String reportContent, String date,
			String departmentName, String teamName, String roomManagerName, String yesPickUserName) {
		text = text.replace("{ReportTitle}", reportTitle);
		text = text.replace("{ReportContent}", reportContent);
		text = text.replace("{DepartmentName}", departmentName);
		text = text.replace("{TeamName}", teamName);
		text = text.replace("{RoomManagerName}", roomManagerName);
		text = text.replace("{YesPickUserName}", yesPickUserName);
		text = text.replace("{Date}", date);
		return text;
	}
}
