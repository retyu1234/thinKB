package com.kb.star.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class AddFunctionController {

	@RequestMapping("/vote")
	public String vote(Model model) {
		return "/addFunction/vote";
	}
	@RequestMapping("/meetingStep")
	public String meetingStep(Model model) {
		return "/addFunction/meetingStep";
	}
	
	
}
