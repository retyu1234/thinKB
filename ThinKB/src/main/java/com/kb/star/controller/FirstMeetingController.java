package com.kb.star.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller
public class FirstMeetingController {

	// 진행 중인 회의 및 단계
	@RequestMapping("/meetingList")
	public String meetingList(Model model) {
		return "/firstMeeting/meetingList";
	}
	
	
}
