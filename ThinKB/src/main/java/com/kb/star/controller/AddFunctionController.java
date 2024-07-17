package com.kb.star.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;

import org.apache.ibatis.session.SqlSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.kb.star.command.addFunction.MakeAorBCommand;
import com.kb.star.dto.AorBDto;
import com.kb.star.util.AorBDao;

@Controller
public class AddFunctionController {
	private static final Logger log = LoggerFactory.getLogger(AddFunctionController.class);
	@Autowired
	private SqlSession sqlSession;

	// 나의 보고서 목록
	@RequestMapping("/myReportList")
	public String myReportList(Model model) {
		System.out.println("AddFunctionController - myReportList");

		return "/addFunction/myReportList";
	}

	// A/B테스트 목록
	@RequestMapping("/AorBList")
	public String AorBList(Model model) {
		System.out.println("AddFunctionController - AorBList");

		AorBDao dao = sqlSession.getMapper(AorBDao.class);
		List<AorBDto> aorBList = dao.getAorBList();
		model.addAttribute("aorBList", aorBList);

		return "/addFunction/AorBList";
	}

	// A/B테스트 생성 form
	@RequestMapping("/makeAorB")
	public String makeAorB() {
		System.out.println("AddFunctionController - makeAorB");

		return "/addFunction/makeAorB";
	}

	// A/B 테스트를 생성 후 목록 페이지로 리다이렉트
	@RequestMapping(value = "/processAorB", method = RequestMethod.POST)
	public String processAorB(MultipartHttpServletRequest request, Model model
	,@RequestParam("variantA") MultipartFile variantA
	,@RequestParam("variantB") MultipartFile variantB
			, @RequestParam String testName
			) throws IOException, ServletException {
		log.info("processAorB");


		System.out.println("AddFunctionController - processAorB");

		// 디버깅 로그 추가
		System.out.println("processAorB method called");
		/*
		 * System.out.println("Test Name: " + testName);
		 * System.out.println("Variant A: " + variantA.getOriginalFilename());
		 * System.out.println("Variant B: " + variantB.getOriginalFilename());
		 * 
		 */
		model.addAttribute("request", request);
		model.addAttribute("variantA", variantA);
		model.addAttribute("variantB", variantB);
		model.addAttribute("testName", testName);

		MakeAorBCommand command = new MakeAorBCommand(sqlSession.getMapper(AorBDao.class));
		command.execute(model);

		return "redirect:/AorBList";
	}

	// 투표
	@RequestMapping("/vote")
	public String vote(Model model) {
		return "/addFunction/vote";
	}

}
