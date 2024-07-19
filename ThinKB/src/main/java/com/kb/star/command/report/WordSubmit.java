package com.kb.star.command.report;

import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;

public class WordSubmit implements ReportCommand {

	SqlSession sqlSession;

	@Autowired
	public WordSubmit(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void execute(Model model) {
		// TODO Auto-generated method stub
		Map<String, Object> map = model.asMap();
		HttpServletRequest request = (HttpServletRequest) map.get("request");
		String name=request.getParameter("name");
		Path inputPath = Paths.get("./upload", "formTemplate.docx");
		// 저장할 Word 파일 경로
		Path outputPath = Paths.get("./upload", "formData_" + name + ".docx");

	}

}
