package com.hanul.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class StyleController {
	@RequestMapping("/list.st")
	public String list(HttpSession session) {
		session.setAttribute("category", "st");
		return "Style/list";
	}

}
