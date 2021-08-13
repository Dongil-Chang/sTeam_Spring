package com.hanul.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QnaController {
	
	@RequestMapping("/list.qa")
	public String list(HttpSession session) {
		session.setAttribute("category", "qa");
		return "QnA/list";
	}

}
