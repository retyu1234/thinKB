package com.kb.star.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class IdeaClassController {
	
	@RequestMapping("/newIdeaRoom")
	public String newIdeaRoom(Model model) {
		return "ideaRoom/newRoom";
	}

}
