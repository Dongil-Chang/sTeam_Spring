package com.hanul.web;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class NoticeController {
	@RequestMapping("/list.no")
	public String list(HttpSession session) {
		session.setAttribute("category", "no");
		return "Notice/list";
	}

}
